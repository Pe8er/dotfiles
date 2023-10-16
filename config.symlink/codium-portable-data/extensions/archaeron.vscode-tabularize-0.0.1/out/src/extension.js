'use strict';
// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
var vscode = require('vscode');
function findSequenceInLine(document, lineNumber, s) {
    var line = document.lineAt(lineNumber);
    return line.text.indexOf(s);
}
function findMaxIndex(lines) {
    var lineIndices = Array.from(lines.values());
    return Math.max.apply(Math, lineIndices);
}
function findSequenceInLines(document, startLine, sequence) {
    var lineNumber = startLine;
    var lines = new Map;
    var charIndex;
    while ((charIndex = findSequenceInLine(document, lineNumber, sequence)) != -1) {
        lines = lines.set(lineNumber, charIndex);
        lineNumber = lineNumber + 1;
    }
    lineNumber = startLine - 1;
    while ((charIndex = findSequenceInLine(document, lineNumber, sequence)) != -1) {
        lines = lines.set(lineNumber, charIndex);
        lineNumber = lineNumber - 1;
    }
    return lines;
}
function insertSpaces(editor, lines) {
    var max = findMaxIndex(lines);
    return editor.edit(function (e) {
        lines.forEach(function (char, line) {
            var filler = " ".repeat(max - char);
            var pos = new vscode.Position(line, char);
            e.insert(pos, filler);
        });
    });
}
function align(editor, sequence) {
    var lineNumber = editor.selection.active.line;
    var indices = findSequenceInLines(editor.document, lineNumber, sequence);
    return insertSpaces(editor, indices);
}
function activate(context) {
    var tabularize = vscode.commands.registerCommand('vscode-tabularize.tabularize', function () {
        if (vscode.window.activeTextEditor) {
            var editor = vscode.window.activeTextEditor;
            var text = editor.document.getText(editor.selection);
            align(editor, text);
        }
    });
    var tabularizeInput = vscode.commands.registerCommand('vscode-tabularize.tabularize-input', function () {
        var answer = vscode.window.showInputBox();
        answer.then(function (text) {
            if (vscode.window.activeTextEditor) {
                var editor = vscode.window.activeTextEditor;
                align(editor, text);
            }
        });
    });
    context.subscriptions.push(tabularize);
    context.subscriptions.push(tabularizeInput);
}
exports.activate = activate;
// this method is called when your extension is deactivated
function deactivate() {
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map