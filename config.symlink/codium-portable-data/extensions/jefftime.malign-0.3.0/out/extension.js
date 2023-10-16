"use strict";
/* This file is part of Malign
 *
 * Copyright 2019, Jeffery Stager
 *
 * Malign is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Malign is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */
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
const vscode = require("vscode");
function activate(context) {
    let disposable = vscode.commands.registerCommand('extension.malign', () => {
        const ed = vscode.window.activeTextEditor;
        if (ed === undefined)
            return;
        // Text per selection
        let originalTexts = [];
        ed.selections.forEach(sel => originalTexts.push(ed.document.getText(sel)));
        const resetOriginalText = () => __awaiter(this, void 0, void 0, function* () {
            yield ed.edit(eb => {
                for (let i = 0; i < originalTexts.length; ++i) {
                    eb.replace(ed.selections[i], originalTexts[i]);
                }
            });
        });
        // Input for regex
        let input = vscode.window.createInputBox();
        let accept = false;
        input.onDidAccept(() => {
            accept = true;
            input.hide();
        });
        input.onDidHide(() => __awaiter(this, void 0, void 0, function* () {
            if (accept)
                return;
            // Set back to original text if user didn't accept
            yield resetOriginalText();
        }));
        input.onDidChangeValue((str) => __awaiter(this, void 0, void 0, function* () {
            yield resetOriginalText();
            if (str === '')
                return;
            yield ed.edit(eb => {
                ed.selections.forEach(sel => {
                    // Start processing current selection text
                    let lines = ed.document.getText(sel).split('\n');
                    if (lines.length === 0)
                        return;
                    ;
                    // Split lines on user input
                    let splitLines = [];
                    lines.forEach(line => {
                        let rgx = new RegExp(`(${input.value})`);
                        splitLines.push({
                            indent: line.length - line.trimLeft().length,
                            matches: line.match(rgx) !== null,
                            splits: line.split(rgx)
                        });
                    });
                    // Get the minimum indent where the first split of the regex is not
                    // empty. This means that if the line starts off with a regex match,
                    // we want to align it to something that doesn't because the latter
                    // is indentation-sensitive
                    const minIndent = Math.min.apply(Number.MAX_SAFE_INTEGER, splitLines
                        .map(line => {
                        return {
                            indent: line.indent,
                            exclude: line.splits[0].length === 0 || !line.matches
                        };
                    })
                        .filter(line => !line.exclude)
                        .map(linePair => linePair.indent));
                    // Malign will align against line with smallest splits, so get the
                    // minimum number of split sections
                    let nSections = Number.MAX_SAFE_INTEGER;
                    splitLines.forEach(line => {
                        // Get minimum number of nSections
                        if (!line.matches)
                            return line.splits;
                        nSections = line.splits.length < nSections
                            ? line.splits.length
                            : nSections;
                        line.splits = line.splits.map(split => split.trim());
                    });
                    // Get maximum split lengths
                    let splitLengths = new Array(nSections);
                    splitLengths.fill(0);
                    splitLines.forEach(line => {
                        // Make sure this is a line that requires alignment
                        if (line.splits.length < nSections)
                            return;
                        for (let i = 0; i < nSections; ++i) {
                            splitLengths[i] = line.splits[i].length > splitLengths[i]
                                ? line.splits[i].length
                                : splitLengths[i];
                        }
                    });
                    // Align the line splits
                    splitLines.forEach(line => {
                        if (!line.matches)
                            return;
                        // Don't pad the final split
                        for (let i = 0; i < splitLengths.length - 1; ++i) {
                            line.splits[i] = line.splits[i].padEnd(splitLengths[i], ' ');
                        }
                    });
                    let newLines = splitLines
                        .map(line => {
                        if (!line.matches) {
                            // Return the original line
                            return line.splits.join('');
                        }
                        else {
                            return ''.padStart(minIndent).concat(line.splits
                                .filter(split => split.length > 0)
                                .join(' ')
                                .trimRight());
                        }
                    })
                        .join('\n');
                    eb.replace(sel, newLines);
                });
            });
        }));
        input.show();
    });
    context.subscriptions.push(disposable);
}
exports.activate = activate;
function deactivate() { }
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map