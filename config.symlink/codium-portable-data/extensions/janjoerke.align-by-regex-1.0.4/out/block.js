"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const Part_1 = require("./Part");
const string_utils_1 = require("./string-utils");
const vscode = require("vscode");
class Block {
    constructor(text, input, startLine, eol) {
        this.lines = [];
        let splitString;
        if (eol === vscode.EndOfLine.CRLF) {
            splitString = '\r\n';
        }
        else {
            splitString = '\n';
        }
        let textLines = text.split(splitString);
        let regex = string_utils_1.checkedRegex(input);
        /* basic protection from bad regexes */
        if (regex !== undefined) {
            for (let i = 0; i < textLines.length; i++) {
                let lineText = textLines[i];
                let lineObject = { number: startLine + i, parts: [] };
                /* get all matches at once */
                let textStartPosition = 0;
                let result;
                while (result = regex.exec(lineText)) {
                    let matchedSep = result[0];
                    if (matchedSep === "") {
                        /* if the regex return 0 length matches, e.g. the '|' operator, stop pushing line objects */
                        break;
                    }
                    let regexStartPosition = regex.lastIndex - matchedSep.length;
                    lineObject.parts.push({ type: Part_1.PartType.Text, value: lineText.substring(textStartPosition, regexStartPosition) });
                    lineObject.parts.push({ type: Part_1.PartType.Regex, value: matchedSep });
                    textStartPosition = regex.lastIndex;
                }
                lineObject.parts.push({ type: Part_1.PartType.Text, value: lineText.substring(textStartPosition, lineText.length) });
                this.lines.push(lineObject);
            }
        }
    }
    trim() {
        for (let line of this.lines) {
            for (let i = 0; i < line.parts.length; i++) {
                let part = line.parts[i];
                if (i === 0) {
                    part.value = string_utils_1.trimEndButOne(part.value);
                }
                else if (i < line.parts.length - 1) {
                    part.value = string_utils_1.trimButOne(part.value);
                }
                else {
                    let intermediate = string_utils_1.trimStartButOne(part.value);
                    part.value = string_utils_1.trimEnd(intermediate);
                }
            }
        }
        return this;
    }
    align() {
        /* get editor tab size */
        let tabSize = vscode.workspace.getConfiguration('editor', null).get('tabSize');
        /* check that we actually got a valid tab size and that it isn't set to a value < 1. */
        if (tabSize === undefined || tabSize < 1) {
            /* give helpful error message on console */
            console.log('Error [Align by Regex]: Invalid tab size setting "editor.tabSize" for alignment.');
            /* assume tab size == 1 if tab size is missing */
            tabSize = 1;
        }
        /* get maximum number of parts */
        let maxNrParts = 1;
        for (let idx = 0; idx < this.lines.length; ++idx) {
            let len = this.lines[idx].parts.length;
            if (len > maxNrParts) {
                maxNrParts = len;
            }
        }
        /* create array with the right size and initialize array with 0 */
        let maxLength = Array(maxNrParts).fill(0);
        for (let line of this.lines) {
            // no match, only one part => ignore line in max length calculation
            if (line.parts.length > 1) {
                for (let i = 0; i < line.parts.length; i++) {
                    maxLength[i] = Math.max(maxLength[i], string_utils_1.tabAwareLength(line.parts[i].value, tabSize));
                }
            }
        }
        for (let line of this.lines) {
            for (let i = 0; i < line.parts.length - 1; i++) {
                line.parts[i].value = string_utils_1.extendToLength(line.parts[i].value, maxLength[i], tabSize);
            }
        }
        return this;
    }
}
exports.Block = Block;
//# sourceMappingURL=block.js.map