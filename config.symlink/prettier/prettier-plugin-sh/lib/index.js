import path from 'node:path';
import { fileURLToPath } from 'node:url';
import sh from 'mvdan-sh';
import { createSyncFn } from 'synckit';
import { languages } from './languages.js';
/* c8 ignore next 4 */
const _dirname = typeof __dirname === 'undefined'
    ? path.dirname(fileURLToPath(import.meta.url))
    : __dirname;
const { syntax } = sh;
const processor = createSyncFn(path.resolve(_dirname, 'worker.js'));
class ShParseError extends SyntaxError {
    constructor(err) {
        super(err.Text);
        this.cause = err;
        this.loc = {
            start: {
                column: err.Pos.Col(),
                line: err.Pos.Line(),
            },
        };
    }
}
class ShSyntaxParseError extends SyntaxError {
    constructor(err) {
        const error = err;
        super(/* c8 ignore next */ ('Text' in error && error.Text) || error.message);
        this.cause = err;
        // `error instanceof ParseError` won't not work because the error is thrown wrapped by `synckit`
        if ('Pos' in error && error.Pos != null && typeof error.Pos === 'object') {
            this.loc = { start: { column: error.Pos.Col, line: error.Pos.Line } };
        }
    }
}
// eslint-disable-next-line @typescript-eslint/ban-types
const isFunction = (val) => typeof val === 'function';
const ShPlugin = {
    languages,
    parsers: {
        sh: {
            parse: (text, _parsers, { filepath, keepComments = true, stopAt, variant, experimentalWasm, }) => {
                if (experimentalWasm) {
                    try {
                        return processor(text, {
                            filepath,
                            keepComments,
                            stopAt,
                            variant,
                        });
                    }
                    catch (err) {
                        throw new ShSyntaxParseError(err);
                    }
                }
                const parserOptions = [syntax.KeepComments(keepComments)];
                /* c8 ignore next 8 */
                if (stopAt != null) {
                    parserOptions.push(syntax.StopAt(stopAt));
                }
                if (variant != null) {
                    parserOptions.push(syntax.Variant(variant));
                }
                try {
                    return syntax.NewParser(...parserOptions).Parse(text, filepath);
                }
                catch (err) {
                    throw new ShParseError(err);
                }
            },
            astFormat: 'sh',
            locStart: node => 
            /* c8 ignore next */
            isFunction(node.Pos) ? node.Pos().Offset() : node.Pos.Offset,
            locEnd: node => 
            /* c8 ignore next */
            isFunction(node.End) ? node.End().Offset() : node.End.Offset,
        },
    },
    printers: {
        sh: {
            print: (path, { originalText, filepath, useTabs, tabWidth, 
            /* c8 ignore next */
            indent = useTabs ? 0 : tabWidth, binaryNextLine = true, switchCaseIndent = true, spaceRedirects = true, keepPadding, minify, functionNextLine, experimentalWasm, }) => {
                if (experimentalWasm) {
                    return processor(path.getNode(), {
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
                        functionNextLine,
                    });
                }
                return syntax
                    .NewPrinter(syntax.Indent(indent), syntax.BinaryNextLine(binaryNextLine), syntax.SwitchCaseIndent(switchCaseIndent), syntax.SpaceRedirects(spaceRedirects), syntax.KeepPadding(keepPadding), syntax.Minify(minify), syntax.FunctionNextLine(functionNextLine))
                    .Print(path.getValue());
            },
        },
    },
    options: {
        keepComments: {
            since: '0.1.0',
            category: 'Output',
            type: 'boolean',
            default: true,
            description: 'KeepComments makes the parser parse comments and attach them to nodes, as opposed to discarding them.',
        },
        stopAt: {
            since: '0.1.0',
            category: 'Config',
            type: 'path',
            description: [
                'StopAt configures the lexer to stop at an arbitrary word, treating it as if it were the end of the input. It can contain any characters except whitespace, and cannot be over four bytes in size.',
                'This can be useful to embed shell code within another language, as one can use a special word to mark the delimiters between the two.',
                'As a word, it will only apply when following whitespace or a separating token. For example, StopAt("$$") will act on the inputs "foo $$" and "foo;$$", but not on "foo \'$$\'".',
                'The match is done by prefix, so the example above will also act on "foo $$bar".',
            ].join('\n'),
        },
        variant: {
            since: '0.1.0',
            category: 'Config',
            type: 'choice',
            default: undefined,
            choices: [
                {
                    value: 0,
                    description: 'Bash',
                },
                {
                    value: 1,
                    description: 'POSIX',
                },
                {
                    value: 2,
                    description: 'MirBSDKorn',
                },
                {
                    value: 3,
                    description: 'Bats',
                },
            ],
            description: 'Variant changes the shell language variant that the parser will accept.',
        },
        indent: {
            since: '0.1.0',
            category: 'Format',
            type: 'int',
            description: 'Indent sets the number of spaces used for indentation. If set to 0, tabs will be used instead.',
        },
        binaryNextLine: {
            since: '0.1.0',
            category: 'Output',
            type: 'boolean',
            default: true,
            description: 'BinaryNextLine will make binary operators appear on the next line when a binary command, such as a pipe, spans multiple lines. A backslash will be used.',
        },
        switchCaseIndent: {
            since: '0.1.0',
            category: 'Format',
            type: 'boolean',
            default: true,
            description: 'SwitchCaseIndent will make switch cases be indented. As such, switch case bodies will be two levels deeper than the switch itself.',
        },
        spaceRedirects: {
            since: '0.1.0',
            category: 'Format',
            type: 'boolean',
            default: true,
            description: "SpaceRedirects will put a space after most redirection operators. The exceptions are '>&', '<&', '>(', and '<('.",
        },
        keepPadding: {
            since: '0.1.0',
            category: 'Format',
            type: 'boolean',
            default: false,
            description: [
                'KeepPadding will keep most nodes and tokens in the same column that they were in the original source. This allows the user to decide how to align and pad their code with spaces.',
                'Note that this feature is best-effort and will only keep the alignment stable, so it may need some human help the first time it is run.',
            ].join('\n'),
        },
        minify: {
            since: '0.1.0',
            category: 'Output',
            type: 'boolean',
            default: false,
            description: 'Minify will print programs in a way to save the most bytes possible. For example, indentation and comments are skipped, and extra whitespace is avoided when possible.',
        },
        functionNextLine: {
            since: '0.1.0',
            category: 'Format',
            type: 'boolean',
            default: false,
            description: "FunctionNextLine will place a function's opening braces on the next line.",
        },
        experimentalWasm: {
            since: '0.13.0',
            category: 'config',
            type: 'boolean',
            default: false,
            description: 'Whether prefer to use experimental `sh-syntax` instead of `mvdan-sh`, it could still be buggy',
        },
    },
};
export default ShPlugin;
//# sourceMappingURL=index.js.map