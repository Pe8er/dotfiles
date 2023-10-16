/*
 * processBridge
 * https://github.com/anseki/process-bridge
 *
 * Copyright (c) 2016 anseki
 * Licensed under the MIT license.
 */

'use strict';

var
  RE_MESSAGE_LINE = /^([^\n\r]*)[\n\r]+([\s\S]*)$/,
  IPC_RETRY_INTERVAL = 1000,

  options = { // Default options
    hostModule: 'electron-prebuilt',
    funcGetHostPath: function(moduleExports) { return moduleExports; },
    dependenciesSatisfy: true,
    ipc: true,
    singleTask: true
  },

  requests = {}, curRequestId = 0, tranRequests = {}, retryTimer,
  childProc, stdioData = '', stderrData = '', waitingRequests, triedInit, orgWd;

/**
 * Callback that handles the parsed message object.
 * @callback procMessage
 * @param {string} requestId - ID of the message.
 * @param {Object} message - The message object.
 */

/**
 * Normalize an IPC message.
 * @param {Object} message - IPC message.
 * @param {procMessage} cb - Callback function that is called.
 * @returns {any} result - Something that was returned by `cb`.
 */
function parseIpcMessage(message, cb) {
  var requestId;
  if (message._requestId == null) { // eslint-disable-line eqeqeq
    throw new Error('Invalid message: ' + JSON.stringify(message));
  }
  requestId = message._requestId;
  delete message._requestId;
  return cb(+requestId, message);
}

/**
 * Extract & normalize an IPC message from current input stream lines, and return remaining data.
 * @param {string} lines - current input stream.
 * @param {boolean} [getLine] - Get a line as plain string.
 * @param {procMessage|Function} cb - Callback function that is called. It is called with a line if `getLine` is `true`.
 * @returns {string} lines - remaining data.
 */
function parseMessageLines(lines, getLine, cb) {
  var matches, line, lineParts;

  if (arguments.length < 3) {
    cb = getLine;
    getLine = false;
  }

  RE_MESSAGE_LINE.lastIndex = 0;
  while ((matches = RE_MESSAGE_LINE.exec(lines))) {
    line = matches[1];
    lines = matches[2];
    if (line === '') {
      continue;
    } else if (getLine) {
      cb(line); // eslint-disable-line callback-return
    } else {
      lineParts = line.split('\t', 2);
      if (lineParts.length < 2 || !lineParts[0] || !lineParts[1]) {
        throw new Error('Invalid message: ' + line);
      }
      cb(+lineParts[0], JSON.parse(lineParts[1])); // eslint-disable-line callback-return
    }
  }
  return lines;
}

/**
 * @param {Function} errorHandle - Wrapper that catch an error.
 * @param {Function} cbReceiveHostCmd - Callback function that is called with host command.
 * @param {Function} cbInitDone - Callback function that is called when module was initialized.
 * @returns {void}
 */
function getHostCmd(errorHandle, cbReceiveHostCmd, cbInitDone) { // cbReceiveHostCmd(error, hostPath)
  var pathUtil = require('path'), semver = require('semver'),
    baseModuleObj = module.parent,
    baseDir = pathUtil.dirname(baseModuleObj.filename),
    basePackageRoot, basePackageInfo, error,
    hostVersionRange, hostModuleExports, hostCmd;

  function fsExist(path) {
    var fs = require('fs');
    try {
      fs.accessSync(path); // Check only existence.
      return true;
    } catch (error) { /* ignore */ }
    return false;
  }

  function getPackageRoot(startPath) {
    var dirPath = pathUtil.resolve(startPath || ''), parentPath;
    while (true) {
      if (fsExist(pathUtil.join(dirPath, 'package.json'))) { return dirPath; }
      parentPath = pathUtil.join(dirPath, '..');
      if (parentPath === dirPath) { break; } // root
      dirPath = parentPath;
    }
    return null;
  }

  function initModule(cb) {
    var npm, npmPath;

    function getNpm() {
      var execSync;

      function lookAround(path) {
        var exPath;
        if (/[\/\\]bin$/.test(path)) {
          path = pathUtil.join(path, '..');
        }
        if (fsExist((exPath = pathUtil.join(path, 'node_modules/npm')))) {
          console.log('lookAround: %s -> %s', path, exPath);
          return exPath;
        } else if (fsExist((exPath = pathUtil.join(path, 'lib/node_modules/npm')))) {
          console.log('lookAround: %s -> %s', path, exPath);
          return exPath;
        }
        console.log('lookAround not found NPM: %s', path);
        return null;
      }

      try {
        npm = require('npm');
        return true;
      } catch (error) {
        console.log(error);
        console.warn('Continue trying to get NPM...');
      }

      execSync = require('child_process').execSync;

      // Retry with `npm help` (v1.1.0+)
      console.warn('Try to get NPM via usage info.');
      try {
        npmPath = (function() {
          var usageInfo = execSync('npm help', {encoding: 'utf8'}),
            matches = /npm\@\S+ +([^\n]+)/.exec(usageInfo);
          if (!matches) {
            console.log('Couldn\'t parse usage info.');
            console.log(usageInfo.split(/\n/)
              .filter(function(line) { return !!line.trim(); }).slice(-3).join('<br>')); // last 3 lines
            return null;
          }
          return matches[1];
        })();
        if (npmPath) {
          npm = require(npmPath);
          return true;
        }
      } catch (error) { console.log(error); }

      // Retry with `npm` path
      console.warn('Try to get NPM via command path.');
      try {
        npmPath = (function() {
          var path = execSync( // Win <Vista and <Server2008 don't have `where`.
            (process.platform === 'win32' ? 'where' : 'which') + ' npm', {encoding: 'utf8'});
          path = (path || '').replace(/^([^\n]+)[\s\S]*/, '$1');
          if (!path) {
            console.log('which:none');
            return null;
          }
          path = pathUtil.dirname(path);
          if (/[\/\\]npm[\/\\]bin$/.test(path)) {
            return pathUtil.join(path, '..');
          }
          return lookAround(path);
        })();
        if (npmPath) {
          npm = require(npmPath);
          return true;
        }
      } catch (error) { console.log(error); }

      // Retry with `npm root -g` (It might be not environment variables)
      console.warn('Try to get NPM in global directory.');
      try {
        npm = require((npmPath = pathUtil.join(
          execSync('npm root -g', {encoding: 'utf8'}).replace(/\n+$/, ''), 'npm')));
        return true;
      } catch (error) { console.log(error); }

      // Retry with `node` path
      console.warn('Try to get NPM via node path.');
      try {
        npmPath = (function() {
          var path = execSync('node -p "process.execPath"', {encoding: 'utf8'}); // not current executable
          return lookAround(pathUtil.dirname(path));
        })();
        if (npmPath) {
          npm = require(npmPath);
          return true;
        }
      } catch (error) { console.log(error); }

      return false;
    }

    console.warn('Start initializing module...');
    console.info('Node.js@%s', (process.version + '').replace(/^v/i, ''));
    if (triedInit) { throw new Error('Cannot initialize module'); }
    triedInit = true;

    if (!getNpm()) { throw new Error('Cannot get NPM'); }
    console.info('NPM@%s', (npm.version + '').replace(/^v/i, ''));
    console.info('NPM directory path: %s', (npmPath || ''));
    try {
      npmPath = require.resolve(npmPath || 'npm'); // npmPath is package dir
    } catch (error) { throw error; }
    console.info('NPM resolved path: %s', npmPath);

    console.info('Base directory path: %s', baseDir);
    // npm might ignore `prefix` option.
    if (!orgWd) { orgWd = process.cwd(); }
    process.chdir(baseDir);

    npm.load({prefix: baseDir,
      npat: false, dev: false, production: true, // disable `devDependencies`
      loglevel: 'silent', spin: false, progress: false // disable progress indicator
    }, errorHandle(function(error) {
      var npmSpawn, npmSpawnPath;
      if (error) { throw error; }

      // Wrap `spawn.js` for dropping output from child.
      try {
        npmSpawnPath = require.resolve(pathUtil.join(pathUtil.dirname(npmPath), 'utils/spawn.js'));
        console.warn('Try to load: %s', npmSpawnPath);
        require(npmSpawnPath);
      } catch (error) {
        throw error.code === 'MODULE_NOT_FOUND' ?
          new Error('Unknown version of NPM') : error;
      }
      npmSpawn = require.cache[npmSpawnPath].exports;
      if (typeof npmSpawn !== 'function') { throw new Error('Unknown version of NPM or spawn.js'); }
      require.cache[npmSpawnPath].exports = function(cmd, args, options) {
        console.warn('Spawn in silent-mode: %s %s', cmd, args.join(' '));
        options.stdio = 'ignore';
        return npmSpawn(cmd, args, options);
      };

      // `hostVersionRange` means that `options.hostModule` and version are specified in `package.json`.
      npm.commands.install(hostVersionRange ? [] : [options.hostModule], errorHandle(function(error) {
        if (orgWd) { // restore
          try {
            process.chdir(orgWd);
            orgWd = null;
          } catch (error) { /* ignore */ }
        }
        if (error) { throw error; }
        cb();
      }));
      // npm.registry.log.on('log', function(message) { console.dir(message); });
    }));
  }

  function isSatisfiedModule(moduleName, versionRange) {
    var modulePath, packageRoot, packagePath, packageInfo, satisfied = false;

    console.info('Check version of: %s', moduleName);
    try {
      // modulePath = baseModuleObj.require.resolve(moduleName)
      // This works as if `module.require.resolve()`
      // https://github.com/nodejs/node/blob/master/lib/internal/module.js
      modulePath = baseModuleObj.constructor._resolveFilename(moduleName, baseModuleObj);
    } catch (error) {
      if (error.code !== 'MODULE_NOT_FOUND') { throw error; }
      return false;
    }

    if (!(packageRoot = getPackageRoot(pathUtil.dirname(modulePath)))) {
      throw new Error('Cannot get path of module \'' + moduleName + '\'');
    }
    packageInfo = require( // `resolve` to make sure
      (packagePath = require.resolve(pathUtil.join(packageRoot, 'package.json'))));

    if (!semver.valid(packageInfo.version)) {
      throw new Error('Invalid \'' + moduleName + '\' version: ' + packageInfo.version);
    }
    satisfied = semver.satisfies(packageInfo.version, versionRange);

    delete require.cache[modulePath]; // Unload forcibly
    delete require.cache[packagePath]; // Remove cached targetPackageInfo
    baseModuleObj.constructor._pathCache = {}; // Remove cached paths
    return satisfied;
  }

  if ((basePackageRoot = getPackageRoot(baseDir))) {
    baseDir = basePackageRoot;
    basePackageInfo = require(pathUtil.join(basePackageRoot, 'package.json'));
  }

  if (options.hostModule) {
    if (basePackageInfo && basePackageInfo.dependencies &&
        (hostVersionRange = basePackageInfo.dependencies[options.hostModule]) &&
        !semver.validRange(hostVersionRange)) {
      throw new Error('Invalid SemVer Range: ' + hostVersionRange);
    }

    try {
      hostModuleExports = baseModuleObj.require(options.hostModule);
      if (hostVersionRange && !isSatisfiedModule(options.hostModule, hostVersionRange)) {
        error = new Error('Cannot find satisfied version of module \'' + options.hostModule + '\'.');
        error.code = 'MODULE_NOT_FOUND';
        error.isRetried = true;
        initModule(function() {
          if (cbInitDone) { cbInitDone(); }
          getHostCmd(errorHandle, cbReceiveHostCmd); // Retry
        });
        cbReceiveHostCmd(error);
        return;
      }
    } catch (error) {
      if (error.code === 'MODULE_NOT_FOUND') {
        error.isRetried = true;
        initModule(function() {
          if (cbInitDone) { cbInitDone(); }
          getHostCmd(errorHandle, cbReceiveHostCmd); // Retry
        });
      }
      cbReceiveHostCmd(error);
      return;
    }
  }

  if (options.dependenciesSatisfy) {
    if (!hostVersionRange) {
      throw new Error('`options.hostModule` and `package.json` are required.');
    }
    if (basePackageInfo.dependencies &&
        !(Object.keys(basePackageInfo.dependencies).every(function(moduleName) {
          return moduleName === options.hostModule || // options.hostModule was already checked.
            isSatisfiedModule(moduleName, basePackageInfo.dependencies[moduleName]);
        }))) {
      error = new Error('Cannot find satisfied version of dependencies.');
      error.code = 'MODULE_NOT_FOUND';
      error.isRetried = true;
      initModule(function() {
        if (cbInitDone) { cbInitDone(); }
        getHostCmd(errorHandle, cbReceiveHostCmd); // Retry
      });
      cbReceiveHostCmd(error);
      return;
    }
  }

  if (!options.funcGetHostPath) {
    cbReceiveHostCmd(null, 'node');
  } else if ((hostCmd = options.funcGetHostPath(hostModuleExports))) {
    cbReceiveHostCmd(null, hostCmd);
  } else {
    cbReceiveHostCmd(new Error('Couldn\'t get command.'));
  }
}

/**
 * Callback that receives result from host.
 * @callback cbResponse
 * @param {Error|null} error - ID of the message.
 * @param {Object} message - The message object.
 */

/**
 * @param {Object} message - Message that is sent.
 * @param {Array<string>} [args] - Arguments that are passed to host command.
 * @param {cbResponse} cbResponse - Callback function that is called when host returned response.
 * @param {Function} [cbInitDone] - Callback function that is called when target module was
 *    initialized if it is done.
 * @param {Function} [cbStderr] - Callback function that is called with message when host output STDERR.
 *    If the callback returned `true`, the error is ignored.
 * @returns {void}
 */
exports.sendRequest = function(message, args, cbResponse, cbInitDone, cbStderr) {
  var spawn = require('child_process').spawn;

  function errorHandle(fn) {
    return function() {
      try {
        return fn.apply(null, arguments);
      } catch (error) {
        if (!error.isRetried && orgWd) { // restore
          try {
            process.chdir(orgWd);
            orgWd = null;
          } catch (error) { /* ignore */ }
        }
        cbResponse(error);
        return false;
      }
    };
  }

  // Recover failed IPC-sending.
  // In some environment, IPC message does not reach to child, with no error and return value.
  function sendIpc(message) {
    var requestIds;
    clearTimeout(retryTimer);
    if (message) { tranRequests[message._requestId] = message; }
    if ((requestIds = Object.keys(tranRequests)).length) {
      if (!childProc) { throw new Error('Child process already exited.'); }
      requestIds.forEach(function(requestId) {
        console.info('Try to send IPC message: %d', +requestId);
        childProc.send(tranRequests[requestId]);
      });
      retryTimer = setTimeout(errorHandle(sendIpc), IPC_RETRY_INTERVAL);
    }
  }

  function sendMessage(message, cb) {
    if (!childProc) { throw new Error('Child process already exited.'); }
    if (options.singleTask) { requests = {}; }
    requests[++curRequestId] = {cb: cb};
    if (options.ipc) {
      message._requestId = curRequestId;
      sendIpc(message);
    } else {
      childProc.stdin.write([curRequestId, JSON.stringify(message)].join('\t') + '\n');
    }
  }

  function procResponse(requestId, message) {
    if (requests[requestId]) {
      // Check again. (requests that has not curRequestId was already deleted in sendMessage().)
      if (!options.singleTask || requestId === curRequestId) {
        requests[requestId].cb(null, message);
      }
      delete requests[requestId];
    } else {
      console.warn('Unknown or dropped response: %d', +requestId);
    }
  }

  if (typeof args === 'function') {
    cbInitDone = cbResponse;
    cbResponse = args;
    args = [];
  }

  if (childProc) {
    if ((errorHandle(sendMessage))(message, cbResponse) === false) { return; }
  } else {
    if (waitingRequests) { // Getting host was already started.
      if (options.singleTask) {
        waitingRequests = [{message: message, cb: cbResponse}];
      } else {
        waitingRequests.push({message: message, cb: cbResponse});
      }
      return;
    }
    waitingRequests = [{message: message, cb: cbResponse}];

    console.info('Start child process...');
    if ((errorHandle(getHostCmd))(errorHandle, errorHandle(function(error, hostCmd) {
      if (error) { cbResponse(error); return; }

      childProc = spawn(hostCmd, args, {stdio: options.ipc ? ['ipc', 'pipe', 'pipe'] : 'pipe'});

      childProc.on('exit', errorHandle(function(code, signal) {
        var error;
        console.info('Child process exited with code: %s', code);
        childProc = null;
        if (code !== 0) {
          error = new Error('Child process exited with code: ' + code);
          error.code = code;
          error.signal = signal;
          throw error;
        }
      }));

      childProc.on('error', errorHandle(function(error) { throw error; }));

      childProc.stderr.setEncoding('utf8');
      childProc.stderr.on('data', errorHandle(function(chunk) {
        stderrData = parseMessageLines(stderrData + chunk, true, function(line) {
          if (!cbStderr || !cbStderr(line)) { throw new Error(line); }
        });
      }));
      childProc.stderr.on('error', errorHandle(function(error) { throw error; }));

      if (options.ipc) {

        childProc.on('message', errorHandle(function(message) {
          parseIpcMessage(message, function(requestId, message) {
            if (message._accepted) { // to recover failed IPC-sending
              delete tranRequests[requestId];
              return;
            }
            procResponse(requestId, message);
          });
        }));

        childProc.on('disconnect', function() {
          console.info('Child process disconnected');
          childProc = null;
        });

      } else {

        childProc.stdout.setEncoding('utf8');
        childProc.stdout.on('data', errorHandle(function(chunk) {
          stdioData = parseMessageLines(stdioData + chunk, procResponse);
        }));
        childProc.stdout.on('error', errorHandle(function(error) { throw error; }));

        childProc.stdin.on('error', errorHandle(function(error) { throw error; }));

        childProc.on('close', function(code) {
          console.info('Child process pipes closed with code: %s', code);
          childProc = null;
        });

      }

      waitingRequests.forEach(function(request) { sendMessage(request.message, request.cb); });
      waitingRequests = null;
    }), cbInitDone) === false) { return; }
  }
};

/**
 * @param {boolean} force - Disconnect immediately.
 * @returns {void}
 */
exports.closeHost = function(force) {
  if (childProc) {
    if (force) {
      if (options.ipc) {
        childProc.disconnect();
      } else {
        childProc.stdin.end();
      }
      childProc = null;
    } else {
      requests = {}; // Ignore all response.
      tranRequests = {}; // Cancel all requests.
      try {
        exports.sendRequest({_close: true}, [], function() {});
      } catch (error) { /* ignore */ }
    }
  }
};

/**
 * Callback that handles the response message object.
 * @callback procResponse
 * @param {Object} message - The message object.
 */

/**
 * Callback that receives result that is returned to client.
 * @callback cbRequest
 * @param {Object} message - The request message object.
 * @param {procResponse} cb - Callback function that is called with response message.
 */

/**
 * @param {cbRequest} cbRequest - Callback function that is called when received request.
 * @param {Function} cbClose - Callback function that is called when host is closed by main.
 * @returns {void}
 */
exports.receiveRequest = function(cbRequest, cbClose) {
  var closed;

  function sendMessage(requestId, message) {
    if (closed) { throw new Error('Connection already disconnected.'); }
    if (requests[requestId]) {
      // Check again. (requests that has not curRequestId was already deleted in stdin.on('data').)
      if (!options.singleTask || requestId === curRequestId) {
        if (options.ipc) {
          message._requestId = requestId;
          process.send(message);
        } else {
          console.log([requestId, JSON.stringify(message)].join('\t'));
        }
      }
      requests[requestId] = false;
    } // else: Unknown or dropped request
  }

  function procRequest(requestId, message) {
    if (message._close) {
      closed = true; // Avoid doing sendMessage() even if cbClose() failed.
      if (cbClose) {
        cbClose();
        cbClose = null;
      } else {
        throw new Error('Process is exited forcedly.');
      }
      return;
    }
    if (requests.hasOwnProperty(requestId)) { return; } // Duplicated request
    if (options.singleTask) {
      Object.keys(requests).forEach(function(requestId) { requests[requestId] = false; });
    }
    requests[(curRequestId = requestId)] = true;
    cbRequest(message, function(message) { sendMessage(requestId, message); });
  }

  if (options.ipc) {

    process.on('message', function(message) {
      parseIpcMessage(message, function(requestId, message) {
        process.send({_requestId: requestId, _accepted: true}); // to recover failed IPC-sending
        procRequest(requestId, message);
      });
    });

    process.on('disconnect', function() {
      closed = true;
      if (cbClose) {
        cbClose();
        cbClose = null;
      }
    });

  } else {

    process.stdin.resume();
    process.stdin.setEncoding('utf8');
    process.stdin.on('data', function(chunk) {
      stdioData = parseMessageLines(stdioData + chunk, procRequest);
    });
    process.stdin.on('error', function(error) { console.error(error); });

    process.stdin.on('close', function() {
      closed = true;
      if (cbClose) {
        cbClose();
        cbClose = null;
      }
    });

  }
};

exports.setOptions = function(newOptions) {
  if (newOptions) {
    Object.keys(newOptions).forEach(function(optionName) {
      if (options.hasOwnProperty(optionName)) {
        options[optionName] = newOptions[optionName];
      }
    });
  }
  return options;
};
