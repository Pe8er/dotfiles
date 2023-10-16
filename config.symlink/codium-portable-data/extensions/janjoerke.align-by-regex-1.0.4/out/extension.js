'use strict';
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const block_1 = require("./block");
const vscode = require("vscode");
function activate(context) {
    let lastInput;
    let alignByRegex = vscode.commands.registerTextEditorCommand('align.by.regex', (textEditor, edit, args) => __awaiter(this, void 0, void 0, function* () {
        let templates = vscode.workspace.getConfiguration().get('align.by.regex.templates');
        let input = yield vscode.window.showInputBox({ prompt: 'Enter regular expression or template name.', value: lastInput });
        if (input !== undefined && input.length > 0) {
            lastInput = input;
            if (templates !== undefined) {
                let template = templates[input];
                if (template !== undefined) {
                    input = template;
                }
            }
            let selection = textEditor.selection;
            if (!selection.isEmpty) {
                let textDocument = textEditor.document;
                // Don't select last line, if no character of line is selected.
                let endLine = selection.end.line;
                let endPosition = selection.end;
                if (endPosition.character === 0) {
                    endLine--;
                }
                let range = new vscode.Range(new vscode.Position(selection.start.line, 0), new vscode.Position(endLine, textDocument.lineAt(endLine).range.end.character));
                let text = textDocument.getText(range);
                let block = new block_1.Block(text, input, selection.start.line, textDocument.eol).trim().align();
                yield textEditor.edit(e => {
                    for (let line of block.lines) {
                        let deleteRange = new vscode.Range(new vscode.Position(line.number, 0), new vscode.Position(line.number, textDocument.lineAt(line.number).range.end.character));
                        let replacement = '';
                        for (let part of line.parts) {
                            replacement += part.value;
                        }
                        e.replace(deleteRange, replacement);
                    }
                });
            }
        }
    }));
    context.subscriptions.push(alignByRegex);
}
exports.activate = activate;
// this method is called when your extension is deactivated
function deactivate() {
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map