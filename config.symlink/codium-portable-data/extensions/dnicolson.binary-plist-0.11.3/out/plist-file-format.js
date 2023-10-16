"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.PlistFileFormat = void 0;
const vscode = require("vscode");
const child_process_1 = require("child_process");
const commandExists = require("command-exists");
const plist = require("simple-plist");
const fs_1 = require("fs");
const tmp_1 = require("tmp");
class PlutilParser {
    toXml(uri) {
        const tmpFile = (0, tmp_1.fileSync)();
        (0, child_process_1.spawnSync)('plutil', ['-convert', 'xml1', uri, '-o', tmpFile.name]);
        const xmlString = (0, fs_1.readFileSync)(tmpFile.name, 'utf8');
        tmpFile.removeCallback();
        return xmlString;
    }
    toBinary(uri, xmlString) {
        return __awaiter(this, void 0, void 0, function* () {
            const output = (0, child_process_1.spawnSync)('plutil', ['-convert', 'binary1', '-o', uri, '-'], { input: xmlString });
            if (String(output.stdout).length) {
                throw Error(String(output.stdout));
            }
            if (String(output.stderr).length) {
                throw Error(String(output.stderr));
            }
        });
    }
}
class PythonParser {
    toXml(uri) {
        const python = `
import sys, codecs, plistlib

sys.stdout = codecs.getwriter('utf8')(sys.stdout.buffer)

fp = open("""${uri.replace(/\\/g, '\\\\')}""", 'rb')
pl = plistlib.load(fp)
print(plistlib.dumps(pl).decode('utf-8'))
`;
        const output = (0, child_process_1.spawnSync)('python', ['-c', python], { encoding: 'utf8' });
        if (String(output.stderr).length) {
            throw Error(String(output.stderr));
        }
        return String(output.stdout);
    }
    toBinary(uri, xmlString) {
        return __awaiter(this, void 0, void 0, function* () {
            const python = `
import sys, os, codecs, tempfile, shutil, plistlib

sys.stdin = codecs.getreader('utf8')(sys.stdin.buffer)

fp = tempfile.NamedTemporaryFile(mode='wb', delete=False)
pl = plistlib.loads(sys.stdin.read().encode('utf-8'), fmt=plistlib.FMT_XML)
plistlib.dump(pl, fp, fmt=plistlib.FMT_BINARY)
path = fp.name
fp.close()
shutil.copy(path, """${uri.replace(/\\/g, '\\\\')}""")
os.remove(path)
`;
            const output = (0, child_process_1.spawnSync)('python', ['-c', python], { input: xmlString, encoding: 'utf8' });
            if (String(output.stderr).length) {
                throw Error(String(output.stderr));
            }
        });
    }
}
class NodeParser {
    toXml(uri) {
        return plist.stringify(plist.readFileSync(uri));
    }
    toBinary(uri, xmlString) {
        return __awaiter(this, void 0, void 0, function* () {
            const result = yield vscode.window.showQuickPick(['Continue', 'Cancel'], {
                placeHolder: 'Values of type real that are whole numbers will be saved as type integer. Continue?'
            });
            if (result !== 'Continue') {
                throw Error('Save cancelled.');
            }
            const originalConsoleError = console.error;
            const originalConsoleWarn = console.warn;
            console.error = message => { throw Error(`An error occurred saving the file: ${message}`); };
            console.warn = message => { throw Error(`An error occurred saving the file: ${message}`); };
            try {
                const object = plist.parse(xmlString);
                try {
                    plist.writeBinaryFileSync(uri, object);
                }
                catch (message) {
                    throw Error(`An error occurred saving the file: ${message}`);
                }
            }
            catch (message) {
                throw Error(`An error occurred parsing the XML: ${message}`);
            }
            console.error = originalConsoleError;
            console.warn = originalConsoleWarn;
        });
    }
}
class PlistFileFormat {
    constructor(parser = '') {
        if (parser === 'PLUTIL' || (!parser && this._hasPlutil())) {
            this.engine = new PlutilParser();
        }
        else if (parser === 'PYTHON' || (!parser && this._hasPlistlib())) {
            this.engine = new PythonParser();
        }
        else {
            this.engine = new NodeParser();
        }
    }
    _hasPlutil() {
        return commandExists.sync('plutil');
    }
    _hasPlistlib() {
        if (commandExists.sync('python')) {
            const output = (0, child_process_1.spawnSync)('python', ['-c', 'import plistlib; plistlib.load']);
            if (output.stderr.length === 0) {
                return true;
            }
        }
        return false;
    }
    binaryToXml(uri) {
        return this.engine.toXml(uri);
    }
    xmlToBinary(uri, xmlString) {
        return __awaiter(this, void 0, void 0, function* () {
            return this.engine.toBinary(uri, xmlString);
        });
    }
}
exports.PlistFileFormat = PlistFileFormat;
//# sourceMappingURL=plist-file-format.js.map