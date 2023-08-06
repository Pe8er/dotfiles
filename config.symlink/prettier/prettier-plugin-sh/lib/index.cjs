'use strict';

var path = require('node:path');
var node_url = require('node:url');
var sh = require('mvdan-sh');
var synckit = require('synckit');

function _interopDefaultLegacy (e) { return e && typeof e === 'object' && 'default' in e ? e : { 'default': e }; }

var path__default = /*#__PURE__*/_interopDefaultLegacy(path);
var sh__default = /*#__PURE__*/_interopDefaultLegacy(sh);

const languages = [
  {
    "name": "Alpine Abuild",
    "aceMode": "sh",
    "since": "0.1.0",
    "parsers": [
      "sh"
    ],
    "linguistLanguageId": 14,
    "vscodeLanguageIds": [
      "shellscript"
    ],
    "group": "Shell",
    "aliases": [
      "abuild",
      "apkbuild"
    ],
    "filenames": [
      "APKBUILD"
    ],
    "tmScope": "source.shell",
    "codemirrorMode": "shell",
    "codemirrorMimeType": "text/x-sh"
  },
  {
    "name": "CODEOWNERS",
    "aceMode": "gitignore",
    "since": "0.1.0",
    "parsers": [
      "sh"
    ],
    "linguistLanguageId": 321684729,
    "vscodeLanguageIds": [
      "gitignore"
    ],
    "filenames": [
      "CODEOWNERS"
    ],
    "tmScope": "text.codeowners"
  },
  {
    "name": "Dockerfile",
    "aceMode": "dockerfile",
    "since": "0.1.0",
    "parsers": [
      "sh"
    ],
    "linguistLanguageId": 89,
    "vscodeLanguageIds": [
      "dockerfile"
    ],
    "aliases": [
      "Containerfile"
    ],
    "tmScope": "source.dockerfile",
    "extensions": [
      ".dockerfile"
    ],
    "filenames": [
      "Containerfile",
      "Dockerfile"
    ],
    "codemirrorMode": "dockerfile",
    "codemirrorMimeType": "text/x-dockerfile"
  },
  {
    "name": "Gentoo Ebuild",
    "aceMode": "sh",
    "since": "0.1.0",
    "parsers": [
      "sh"
    ],
    "linguistLanguageId": 127,
    "vscodeLanguageIds": [
      "shellscript"
    ],
    "group": "Shell",
    "extensions": [
      ".ebuild"
    ],
    "tmScope": "source.shell",
    "codemirrorMode": "shell",
    "codemirrorMimeType": "text/x-sh"
  },
  {
    "name": "Gentoo Eclass",
    "aceMode": "sh",
    "since": "0.1.0",
    "parsers": [
      "sh"
    ],
    "linguistLanguageId": 128,
    "vscodeLanguageIds": [
      "shellscript"
    ],
    "group": "Shell",
    "extensions": [
      ".eclass"
    ],
    "tmScope": "source.shell",
    "codemirrorMode": "shell",
    "codemirrorMimeType": "text/x-sh"
  },
  {
    "name": "Git Attributes",
    "aceMode": "gitignore",
    "since": "0.1.0",
    "parsers": [
      "sh"
    ],
    "linguistLanguageId": 956324166,
    "vscodeLanguageIds": [
      "gitignore"
    ],
    "group": "INI",
    "aliases": [
      "gitattributes"
    ],
    "filenames": [
      ".gitattributes"
    ],
    "tmScope": "source.gitattributes",
    "codemirrorMode": "shell",
    "codemirrorMimeType": "text/x-sh"
  },
  {
    "name": "Ignore List",
    "aceMode": "gitignore",
    "since": "0.1.0",
    "parsers": [
      "sh"
    ],
    "linguistLanguageId": 74444240,
    "vscodeLanguageIds": [
      "gitignore"
    ],
    "group": "INI",
    "aliases": [
      "ignore",
      "gitignore",
      "git-ignore"
    ],
    "extensions": [
      ".gitignore"
    ],
    "filenames": [
      ".atomignore",
      ".babelignore",
      ".bzrignore",
      ".coffeelintignore",
      ".cvsignore",
      ".dockerignore",
      ".eleventyignore",
      ".eslintignore",
      ".gitignore",
      ".markdownlintignore",
      ".nodemonignore",
      ".npmignore",
      ".prettierignore",
      ".stylelintignore",
      ".vercelignore",
      ".vscodeignore",
      "gitignore-global",
      "gitignore_global"
    ],
    "tmScope": "source.gitignore",
    "codemirrorMode": "shell",
    "codemirrorMimeType": "text/x-sh"
  },
  {
    "name": "OpenRC runscript",
    "aceMode": "sh",
    "since": "0.1.0",
    "parsers": [
      "sh"
    ],
    "linguistLanguageId": 265,
    "vscodeLanguageIds": [
      "shellscript"
    ],
    "group": "Shell",
    "aliases": [
      "openrc"
    ],
    "interpreters": [
      "openrc-run"
    ],
    "tmScope": "source.shell",
    "codemirrorMode": "shell",
    "codemirrorMimeType": "text/x-sh"
  },
  {
    "name": "Shell",
    "aceMode": "sh",
    "since": "0.1.0",
    "parsers": [
      "sh"
    ],
    "linguistLanguageId": 346,
    "vscodeLanguageIds": [
      "shellscript"
    ],
    "aliases": [
      "sh",
      "shell-script",
      "bash",
      "zsh"
    ],
    "extensions": [
      ".sh",
      ".bash",
      ".bats",
      ".cgi",
      ".command",
      ".env",
      ".fcgi",
      ".ksh",
      ".sh.in",
      ".tmux",
      ".tool",
      ".zsh",
      ".zsh-theme"
    ],
    "filenames": [
      ".bash_aliases",
      ".bash_history",
      ".bash_logout",
      ".bash_profile",
      ".bashrc",
      ".cshrc",
      ".env",
      ".env.example",
      ".flaskenv",
      ".kshrc",
      ".login",
      ".profile",
      ".zlogin",
      ".zlogout",
      ".zprofile",
      ".zshenv",
      ".zshrc",
      "9fs",
      "PKGBUILD",
      "bash_aliases",
      "bash_logout",
      "bash_profile",
      "bashrc",
      "cshrc",
      "gradlew",
      "kshrc",
      "login",
      "man",
      "profile",
      "zlogin",
      "zlogout",
      "zprofile",
      "zshenv",
      "zshrc"
    ],
    "interpreters": [
      "ash",
      "bash",
      "dash",
      "ksh",
      "mksh",
      "pdksh",
      "rc",
      "sh",
      "zsh"
    ],
    "tmScope": "source.shell",
    "codemirrorMode": "shell",
    "codemirrorMimeType": "text/x-sh"
  },
  {
    "name": "ShellSession",
    "aceMode": "sh",
    "since": "0.1.0",
    "parsers": [
      "sh"
    ],
    "linguistLanguageId": 347,
    "vscodeLanguageIds": [
      "shellscript"
    ],
    "extensions": [
      ".sh-session"
    ],
    "aliases": [
      "bash session",
      "console"
    ],
    "tmScope": "text.shell-session",
    "codemirrorMode": "shell",
    "codemirrorMimeType": "text/x-sh"
  },
  {
    "name": "Tcsh",
    "aceMode": "sh",
    "since": "0.1.0",
    "parsers": [
      "sh"
    ],
    "linguistLanguageId": 368,
    "vscodeLanguageIds": [
      "shellscript"
    ],
    "group": "Shell",
    "extensions": [
      ".tcsh",
      ".csh"
    ],
    "interpreters": [
      "tcsh",
      "csh"
    ],
    "tmScope": "source.shell",
    "codemirrorMode": "shell",
    "codemirrorMimeType": "text/x-sh"
  },
  {
    "name": "JvmOptions",
    "since": "0.1.0",
    "parsers": [
      "sh"
    ],
    "extensions": [
      ".vmoptions"
    ],
    "filenames": [
      "jvm.options"
    ],
    "vscodeLanguageIds": [
      "jvmoptions"
    ]
  },
  {
    "name": "hosts",
    "since": "0.1.0",
    "parsers": [
      "sh"
    ],
    "filenames": [
      "hosts"
    ],
    "vscodeLanguageIds": [
      "hosts"
    ]
  },
  {
    "name": "dotenv",
    "since": "0.1.0",
    "parsers": [
      "sh"
    ],
    "extensions": [
      ".env"
    ],
    "filenames": [
      ".env.*"
    ],
    "vscodeLanguageIds": [
      "dotenv"
    ]
  }
];

const import_meta = {};
const _dirname = typeof __dirname === "undefined" ? path__default["default"].dirname(node_url.fileURLToPath(import_meta.url)) : __dirname;
const { syntax } = sh__default["default"];
const processor = synckit.createSyncFn(
  path__default["default"].resolve(_dirname, "worker.js")
);
class ShParseError extends SyntaxError {
  constructor(err) {
    super(err.Text);
    this.cause = err;
    this.loc = {
      start: {
        column: err.Pos.Col(),
        line: err.Pos.Line()
      }
    };
  }
}
class ShSyntaxParseError extends SyntaxError {
  constructor(err) {
    const error = err;
    super("Text" in error && error.Text || error.message);
    this.cause = err;
    if ("Pos" in error && error.Pos != null && typeof error.Pos === "object") {
      this.loc = { start: { column: error.Pos.Col, line: error.Pos.Line } };
    }
  }
}
const isFunction = (val) => typeof val === "function";
const ShPlugin = {
  languages,
  parsers: {
    sh: {
      parse: (text, _parsers, {
        filepath,
        keepComments = true,
        stopAt,
        variant,
        experimentalWasm
      }) => {
        if (experimentalWasm) {
          try {
            return processor(text, {
              filepath,
              keepComments,
              stopAt,
              variant
            });
          } catch (err) {
            throw new ShSyntaxParseError(err);
          }
        }
        const parserOptions = [syntax.KeepComments(keepComments)];
        if (stopAt != null) {
          parserOptions.push(syntax.StopAt(stopAt));
        }
        if (variant != null) {
          parserOptions.push(syntax.Variant(variant));
        }
        try {
          return syntax.NewParser(...parserOptions).Parse(text, filepath);
        } catch (err) {
          throw new ShParseError(err);
        }
      },
      astFormat: "sh",
      locStart: (node) => isFunction(node.Pos) ? node.Pos().Offset() : node.Pos.Offset,
      locEnd: (node) => isFunction(node.End) ? node.End().Offset() : node.End.Offset
    }
  },
  printers: {
    sh: {
      print: (path2, {
        originalText,
        filepath,
        useTabs,
        tabWidth,
        indent = useTabs ? 0 : tabWidth,
        binaryNextLine = true,
        switchCaseIndent = true,
        spaceRedirects = true,
        keepPadding,
        minify,
        functionNextLine,
        experimentalWasm
      }) => {
        if (experimentalWasm) {
          return processor(path2.getNode(), {
            originalText,
            filepath,
            useTabs,
            tabWidth,
            indent,
            binaryNextLine,
            switchCaseIndent,
            spaceRedirects,
            keepPadding,
            minify,
            functionNextLine
          });
        }
        return syntax.NewPrinter(
          syntax.Indent(indent),
          syntax.BinaryNextLine(binaryNextLine),
          syntax.SwitchCaseIndent(switchCaseIndent),
          syntax.SpaceRedirects(spaceRedirects),
          syntax.KeepPadding(keepPadding),
          syntax.Minify(minify),
          syntax.FunctionNextLine(functionNextLine)
        ).Print(path2.getValue());
      }
    }
  },
  options: {
    keepComments: {
      since: "0.1.0",
      category: "Output",
      type: "boolean",
      default: true,
      description: "KeepComments makes the parser parse comments and attach them to nodes, as opposed to discarding them."
    },
    stopAt: {
      since: "0.1.0",
      category: "Config",
      type: "path",
      description: [
        "StopAt configures the lexer to stop at an arbitrary word, treating it as if it were the end of the input. It can contain any characters except whitespace, and cannot be over four bytes in size.",
        "This can be useful to embed shell code within another language, as one can use a special word to mark the delimiters between the two.",
        `As a word, it will only apply when following whitespace or a separating token. For example, StopAt("$$") will act on the inputs "foo $$" and "foo;$$", but not on "foo '$$'".`,
        'The match is done by prefix, so the example above will also act on "foo $$bar".'
      ].join("\n")
    },
    variant: {
      since: "0.1.0",
      category: "Config",
      type: "choice",
      default: void 0,
      choices: [
        {
          value: 0,
          description: "Bash"
        },
        {
          value: 1,
          description: "POSIX"
        },
        {
          value: 2,
          description: "MirBSDKorn"
        },
        {
          value: 3,
          description: "Bats"
        }
      ],
      description: "Variant changes the shell language variant that the parser will accept."
    },
    indent: {
      since: "0.1.0",
      category: "Format",
      type: "int",
      description: "Indent sets the number of spaces used for indentation. If set to 0, tabs will be used instead."
    },
    binaryNextLine: {
      since: "0.1.0",
      category: "Output",
      type: "boolean",
      default: true,
      description: "BinaryNextLine will make binary operators appear on the next line when a binary command, such as a pipe, spans multiple lines. A backslash will be used."
    },
    switchCaseIndent: {
      since: "0.1.0",
      category: "Format",
      type: "boolean",
      default: true,
      description: "SwitchCaseIndent will make switch cases be indented. As such, switch case bodies will be two levels deeper than the switch itself."
    },
    spaceRedirects: {
      since: "0.1.0",
      category: "Format",
      type: "boolean",
      default: true,
      description: "SpaceRedirects will put a space after most redirection operators. The exceptions are '>&', '<&', '>(', and '<('."
    },
    keepPadding: {
      since: "0.1.0",
      category: "Format",
      type: "boolean",
      default: false,
      description: [
        "KeepPadding will keep most nodes and tokens in the same column that they were in the original source. This allows the user to decide how to align and pad their code with spaces.",
        "Note that this feature is best-effort and will only keep the alignment stable, so it may need some human help the first time it is run."
      ].join("\n")
    },
    minify: {
      since: "0.1.0",
      category: "Output",
      type: "boolean",
      default: false,
      description: "Minify will print programs in a way to save the most bytes possible. For example, indentation and comments are skipped, and extra whitespace is avoided when possible."
    },
    functionNextLine: {
      since: "0.1.0",
      category: "Format",
      type: "boolean",
      default: false,
      description: "FunctionNextLine will place a function's opening braces on the next line."
    },
    experimentalWasm: {
      since: "0.13.0",
      category: "config",
      type: "boolean",
      default: false,
      description: "Whether prefer to use experimental `sh-syntax` instead of `mvdan-sh`, it could still be buggy"
    }
  }
};

module.exports = ShPlugin;
