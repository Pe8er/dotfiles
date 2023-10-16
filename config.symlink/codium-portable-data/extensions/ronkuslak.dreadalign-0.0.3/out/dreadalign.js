"use strict";
// Disable no console so we can have debugging output:
/* tslint:disable:no-console */
Object.defineProperty(exports, "__esModule", { value: true });
/*
 * THE GRAND LIST OF TODOS:
 *
 * Needs configuration options
 * Need to handle selection starting in the middle of the line more elegantly
 *  (currently just starts splitting at start of selection)
 * Similar for end of select (align entire line?)
 * Better automation of publishing process?
 */
const vscode = require("vscode");
// import { settings } from "cluster";
/**
 * Holding class for settings from the workspace.
 */
class Settings {
}
/**
 * Splits a collection of strings on the passed delimiter, and recombines them
 * into lines of text that are aligned on said delimiter.
 * @param padding String of characters to "pad" the start of each line with.
 * @param delimiter Delimiter string to split each line of text on.
 * @param text Array of strings containing the full text to split.
 * @param prepend String of text to append prior to delimiter when recombining.
 * @param postpend String of text to append after the delimiter when combining.
 */
function splitLineOnDelimiter(padding, delimiter, text, prepend, postpend) {
    // Max size of each line segment:
    const lineSizes = [];
    // Collection of lines trimmed and split on the delimiter:
    const splitLines = [];
    // Collection of text aligned and collated:
    const finalText = [];
    text.forEach((line) => {
        const splitLine = line.trim().split(delimiter);
        splitLines.push(splitLine);
    });
    // Find max length for each line part:
    splitLines.forEach((lineParts) => {
        lineParts.forEach((linePart, idx) => {
            if (!lineSizes[idx]) {
                lineSizes[idx] = linePart.length;
            }
            if (linePart.length > lineSizes[idx]) {
                lineSizes[idx] = linePart.length;
            }
        });
    });
    // Combine split lines with delimiter:
    splitLines.forEach((lineParts) => {
        let line = padding;
        if (lineParts.length === 1) {
            // If we haven't split at all, there was no delimiter; add
            // the full line unedited:
            line += "UNEDITED: " + lineParts[0];
        }
        else {
            // Join line parts with delimiter and pre/postpends:
            lineParts.forEach((linePart, idx) => {
                // Add delimiter if not the first line part:
                if (idx !== 0) {
                    line += (prepend || "") + delimiter + (postpend || "");
                }
                line += linePart;
                // Add postpend if not last item, as we will have another delimiter:
                if (idx < linePart.length) {
                    line += " ".repeat(lineSizes[idx] - linePart.length);
                }
            });
        }
        finalText.push(line);
    });
    return finalText;
}
/**
 * Returns a range, starting at the start of the first line and ending on the
 * last character of the last line, for a selection object.
 * @param selection A VSCode.Selection object for the selection to pull data from.
 */
function getRangeFromSelection(selection) {
    const lineStart = selection.start;
    const lineEnd = selection.end;
    // Ensure selection is more that 1 line:
    if (lineEnd.isBeforeOrEqual(lineStart)) {
        console.log("lineStart prior to lineEnd; failing...");
        return null;
    }
    const editor = vscode.window.activeTextEditor;
    const endLine = editor.document.lineAt(lineEnd.line);
    return new vscode.Range(lineStart.line, 0, lineEnd.line, endLine.range.end.character);
}
/**
 * Returns a range of text between 2 Position objects in the current editor
 * window, pulling the full first and last line.
 * @param selection: A VSCode Selection object for the range of lines desired.
 * @returns array of strings representing the text in the selection area.
 */
function getEditorText(selection) {
    const editor = vscode.window.activeTextEditor;
    const range = getRangeFromSelection(selection);
    return editor.document.getText(range).split("\n");
}
/**
 * Attempts to sort and align strings based on the first line's leading white space and
 * delimiter string, and then reassemble them aligned based on indent level and using
 * the passed replacement seperator or 'delimiter'.
 * @param delimiter Delimiting character to split the string on.
 * @param replacementDelimiter String to replace the delimiter with in aligned strings.
 */
function alignCurrentSelection(delimiter, prepend, postpend) {
    // TODO: Regexs?
    const editor = vscode.window.activeTextEditor;
    // Since we are not adding lines, just editing, grabbing the line numbers
    // of these lines should be fine. - Ozymandias, to TypeScript, 2018:
    // TODO: Explore iterating over this to handle multi-selections
    // const selectedRanges: vscode.Range[] = [];
    // editor.selections.forEach( (s: vscode.Selection) => {
    //     selectedRanges.push(getRangeFromSelection(s));
    // });
    // console.log(selectedRanges);
    const selection = editor.selection;
    const text = getEditorText(selection);
    // The indentation "padding" used on the current line:
    let padding = text[0].match(/^\s*/)[0];
    // An array of strings at the same indentation level:
    let paddedText = [];
    // The singlar string containing the final end result:
    let fixedText = "";
    let line = 0;
    while (line < text.length) {
        const matches = text[line].match(/^\s*/);
        const currentLinePadding = matches[0] || "";
        if (currentLinePadding !== padding) {
            fixedText += splitLineOnDelimiter(padding, delimiter, paddedText, prepend, postpend).join("\n");
            // Will have additional data to add so this block is not the end; so append new line:
            fixedText += "\n";
            // Reset our padding and array of lines to pad to contain new indentation block:
            paddedText = [];
            padding = currentLinePadding;
        }
        paddedText.push(text[line]);
        line++;
    }
    fixedText += splitLineOnDelimiter(padding, delimiter, paddedText, null, null).join("\n");
    editor.edit((builder) => {
        builder.replace(getRangeFromSelection(selection), fixedText);
    });
}
/**
 * Reads the workspace settings for the project, and populates a "Settings"
 * object with users settings or reasonable defaults.
 */
function getSettings() {
    const settings = new Settings();
    const config = vscode.workspace.getConfiguration("dreadalign");
    settings.defaultDelimiter = config.get("Delimiter") || ",";
    settings.defaultPrepend = config.get("Prepend") || " ";
    settings.defaultPostpend = config.get("Postpend") || " ";
    return settings;
}
function activate(context) {
    // The command has been defined in the package.json file
    // Now provide the implementation of the command with  registerCommand
    // The commandId parameter must match the command field in package.json
    // let disposable = vscode.commands.registerCommand('extension.sayHello', () => {
    //     // The code you place here will be executed every time your command is executed
    // });
    const disposable = vscode.commands.registerCommand("extension.loadDreadAlign", () => {
        const editor = vscode.window.activeTextEditor;
        if (!editor || editor.selection.isEmpty || editor.selection.isSingleLine) {
            console.log(`No editor or selection found, returning`);
            return;
        }
        const opts = {
            prompt: "Value to split strings on",
        };
        vscode.window.showInputBox(opts)
            .then((delimiter) => {
            // Ensure we get a fresh set a setting each run:
            const settings = getSettings();
            if (!delimiter) {
                delimiter = settings.defaultDelimiter;
            }
            alignCurrentSelection(delimiter || settings.defaultDelimiter, settings.defaultPrepend, settings.defaultPostpend);
        });
    });
    context.subscriptions.push(disposable);
}
exports.activate = activate;
// this method is called when your extension is deactivated
function deactivate() {
    return;
}
exports.deactivate = deactivate;
//# sourceMappingURL=dreadalign.js.map