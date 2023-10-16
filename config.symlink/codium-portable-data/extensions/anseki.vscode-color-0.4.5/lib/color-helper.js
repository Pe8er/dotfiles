'use strict';
const
vscode = require('vscode'),
Position = vscode.Position,
Selection = vscode.Selection,
common = require('./common.js'),
COMMAND_ID = 'extension.colorHelper',
CSS_FUNCS = ['rgb', 'rgba', 'hsl', 'hsla', 'hwb', 'gray', 'device-cmyk', 'color'],
CSS_KEYWORDS = require('./css-colors.json').reduce((keywords, color) => {
if (color.name) { keywords.push(color.name); }
if (color.alias) { keywords = keywords.concat(color.alias); }
return keywords;
}, []),
FORMATS_NAME = require('./formats-name.json'),
PTN_SINGLE_PAREN = '\\([^\\(]*?\\)',
RE_SINGLE_PAREN = new RegExp(PTN_SINGLE_PAREN, 'g'),
RE_CSS_HEX = /#(?:[0-9a-f]{8}|[0-9a-f]{6}|[0-9a-f]{4}|[0-9a-f]{3})\b/gi,
RE_CSS_KEYWORDS = new RegExp('\\b(?:' +
CSS_KEYWORDS.map(text => text.replace(/[\x00-\x7f]/g, // eslint-disable-line no-control-regex
s => '\\x' + ('00' + s.charCodeAt().toString(16)).substr(-2))).join('|') +
')\\b', 'gi'),
RE_CSS_FUNC = new RegExp('\\b(?:' +
CSS_FUNCS.map(text => text.replace(/[\x00-\x7f]/g, // eslint-disable-line no-control-regex
s => '\\x' + ('00' + s.charCodeAt().toString(16)).substr(-2))).join('|') +
') *' + PTN_SINGLE_PAREN, 'gi'),
RE_CSS_COMMENT = /\/\*[\s\S]*?\*\//g,
RE_DOC_LINE = /^.*?(?:\r\n|\n|\r|$)/gm,
DEFAULT_ARGS = [require('path').join(__dirname, 'app.asar')],
MSG_BLINK_TIME_ON = 1000, MSG_BLINK_TIME_OFF = 200,
MSG_SUPPORT = 'Please visit https://github.com/anseki/vscode-color/issues';
let uiMessage, uiMessageText, messageTimer, processBridge;
function getColorSelections(textEditor) {
const colorSelections = [], linesLen = [];
let doc, matches;
function getPosition(index) {
let lineIndex = -1;
while (++lineIndex < linesLen.length - 1 && index >= linesLen[lineIndex]) {
index -= linesLen[lineIndex];
}
return new Position(lineIndex, index);
}
doc = textEditor.document.getText();
RE_DOC_LINE.lastIndex = 0;
while ((matches = RE_DOC_LINE.exec(doc))) {
linesLen.push(matches[0].length);
if (RE_DOC_LINE.lastIndex >= doc.length) { break; }
}
doc = doc.replace(RE_CSS_COMMENT, comment => ' '.repeat(comment.length))
.replace(RE_CSS_HEX, (match, offset) => {
const strLen = match.length;
colorSelections.push(new Selection(getPosition(offset), getPosition(offset + strLen)));
return ' '.repeat(strLen);
})
.replace(RE_CSS_KEYWORDS, (match, offset) => {
const strLen = match.length;
colorSelections.push(new Selection(getPosition(offset), getPosition(offset + strLen)));
return ' '.repeat(strLen);
});
(() => {
let docLookup = doc, foundParen;
function pickFunc(func, offset) {
const strLen = func.length, padString = ' '.repeat(strLen);
colorSelections.push(new Selection(getPosition(offset), getPosition(offset + strLen)));
doc = doc.substring(0, offset) + padString + doc.substr(offset + strLen);
return padString;
}
function hideParen(paren) {
foundParen = true;
return ' '.repeat(paren.length);
}
do {
foundParen = false;
docLookup = docLookup.replace(RE_CSS_FUNC, pickFunc).replace(RE_SINGLE_PAREN, hideParen);
} while (foundParen);
})();
return colorSelections;
}
function getExSelection(selections, selection) {
return selections.every(inSelection => {
if (selection.isEmpty && inSelection.isEmpty) {
return !selection.start.isEqual(inSelection.start);
} else if (selection.isEmpty !== inSelection.isEmpty) {
return selection.start.isAfterOrEqual(inSelection.end) ||
selection.end.isBeforeOrEqual(inSelection.start);
} else {
if (inSelection.contains(selection)) { return false; }
if (selection.start.isAfterOrEqual(inSelection.end) ||
selection.end.isBeforeOrEqual(inSelection.start)) { return true; }
if (selection.start.isAfterOrEqual(inSelection.start)) {
selection = new Selection(inSelection.end, selection.end);
return true;
} else if (selection.end.isBeforeOrEqual(inSelection.end)) {
selection = new Selection(selection.start, inSelection.start);
return true;
}
return false;
}
}) ? selection : null;
}
function showMessage(message) {
let isOff;
clearTimeout(messageTimer);
if (uiMessage) {
uiMessage.dispose();
uiMessage = null;
isOff = true;
}
if (message) {
uiMessageText = message;
isOff = false;
} else if (message === false) {
return;
}
if (isOff) {
messageTimer = setTimeout(showMessage, MSG_BLINK_TIME_OFF);
} else {
uiMessage = vscode.window.setStatusBarMessage(uiMessageText);
messageTimer = setTimeout(showMessage, MSG_BLINK_TIME_ON);
}
}
function pickConvert(command, formatId) {
let textEditor, orgSelections, selections, colorSelections, orgColor = '', config;
function procReplace(replacement) {
const selectionsIndex = selections.map((v, i) => i);
function unselect(selections) {
textEditor.selections = (selections || textEditor.selections).map(
selection => new Selection(selection.end, selection.end));
}
function editReplace() {
const index = selectionsIndex.shift(),
newText = command === 'pick' ? replacement : replacement[index],
selection = selections[index];
if (newText) {
textEditor.edit(edit => { edit.replace(selection, newText); })
.then(selectionsIndex.length ? editReplace : () => { unselect(); });
} else {
(selectionsIndex.length ? editReplace : unselect)();
}
}
if (selectionsIndex.length) {
unselect(selections);
selectionsIndex.sort(
(a, b) => selections[b].start.compareTo(selections[a].start));
editReplace();
}
}
if (!(textEditor = vscode.window.activeTextEditor)) {
console.warn('Cannot execute ' + COMMAND_ID + ' because there is no active text editor.');
return;
}
orgSelections = textEditor.selections.slice();
colorSelections = getColorSelections(textEditor);
selections = orgSelections.reduce((selections, selection) => {
const colorSelection = colorSelections.find(colorSelection => {
let exSelection;
return selections.indexOf(colorSelection) < 0 && colorSelection.contains(selection) &&
(exSelection = getExSelection(selections, colorSelection)) &&
exSelection.isEqual(colorSelection);
});
let exSelection;
if (colorSelection) {
selections.push(colorSelection);
if (!orgColor) {
orgColor = textEditor.document.getText(colorSelection)
.replace(RE_CSS_COMMENT, '').replace(/\s+/g, ' ');
}
} else if ((exSelection = getExSelection(selections, selection))) {
selections.push(exSelection);
}
return selections;
}, []);
textEditor.selections = selections;
if (!processBridge) {
processBridge = require('process-bridge');
delete process.env.ELECTRON_RUN_AS_NODE;
delete process.env.ATOM_SHELL_INTERNAL_RUN_AS_NODE;
process.env.ELECTRON_NO_ATTACH_CONSOLE = true;
}
config = vscode.workspace.getConfiguration('colorHelper');
const args = DEFAULT_ARGS.slice();
if (config.get('disableGpu') === 1 ||
config.get('disableGpu') === -1 && process.platform === 'linux') {
args.push('--enable-transparent-visuals');
args.push('--disable-gpu');
}
try {
processBridge.sendRequest({
command: command,
value: command === 'pick' ? orgColor :
selections.map(selection => textEditor.document.getText(selection)),
formatId: formatId,
form: config.get('pickerForm'),
storeDir: config.get('storeDir'),
formatsOrder: config.get('formatsOrder'), // pick
disableShadow: !!config.get('disableShadow'),
disableTransparent: !!config.get('disableTransparent')
}, args, (error, message) => {
showMessage(false);
if (error) {
if (error.isRetried) {
console.warn('Retry (' + error + ')');
showMessage('$(watch)\tPlease wait a while for setting up the extension...');
return;
}
textEditor.selections = orgSelections;
console.error(error);
vscode.window.showErrorMessage('[processBridge]: ' + error);
vscode.window.showInformationMessage(MSG_SUPPORT);
return;
}
if (message.value && (command !== 'convert' || message.value.some(value => !!value))) {
procReplace(message.value);
} else {
textEditor.selections = orgSelections;
}
if (!config.get('resident')) {
processBridge.closeHost();
}
},
() => { showMessage(false); },
stderr => { console.warn('[STDERR]: ' + stderr); return true; });
} catch (error) {
console.error(error);
vscode.window.showErrorMessage('[processBridge]: ' + error);
vscode.window.showInformationMessage(MSG_SUPPORT);
return;
}
}
exports.pick = () => { pickConvert('pick'); };
exports.convert = () => {
const RE_DESC = /^([\s\S]+?)\n\n/;
vscode.window.showQuickPick(
common.getFormatsOrder(vscode.workspace.getConfiguration('colorHelper').get('formatsOrder'))
.map(formatId => {
const quickPickItem = {formatId: formatId, label: FORMATS_NAME[formatId].label};
let matches;
if (FORMATS_NAME[formatId].description &&
(matches = RE_DESC.exec(FORMATS_NAME[formatId].description))) {
quickPickItem.description = matches[1].replace(/\n/g, ' / ');
}
return quickPickItem;
})
).then(item => {
if (item) {
pickConvert('convert', item.formatId);
}
});
};
exports.deactivate = () => {
if (processBridge) { processBridge.closeHost(); }
};
{
let reNative = /^function\s+[^\{]*\{\s*\[native code\]\s*\}$/i;
if (!console.info || !reNative.test(console.log + '') && reNative.test(console.info + '')) {
console.info = console.log;
}
}