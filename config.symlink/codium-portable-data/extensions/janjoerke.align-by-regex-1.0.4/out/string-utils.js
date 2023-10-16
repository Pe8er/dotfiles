"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function trimStart(value) {
    return value.replace(/^\s+([^\s].*)/, '$1');
}
exports.trimStart = trimStart;
function trimStartButOne(value) {
    return value.replace(/^\s+([^\s].*)/, ' $1');
}
exports.trimStartButOne = trimStartButOne;
function trimEnd(value) {
    return value.replace(/(.*[^\s])\s+$/, '$1');
}
exports.trimEnd = trimEnd;
function trimEndButOne(value) {
    return value.replace(/(.*[^\s])\s+$/, '$1 ');
}
exports.trimEndButOne = trimEndButOne;
function trimButOne(value) {
    let result = value;
    result = trimStartButOne(result);
    result = trimEndButOne(result);
    return result;
}
exports.trimButOne = trimButOne;
function extendToLength(value, length, tabSize) {
    return value + ' '.repeat(Math.max(0, length - tabAwareLength(value, tabSize)));
}
exports.extendToLength = extendToLength;
function tabAwareLength(value, tabSize) {
    var length = 0;
    for (let idx = 0; idx < value.length; ++idx) {
        length += value.charAt(idx) === "\t" ? tabSize : 1;
    }
    return length;
}
exports.tabAwareLength = tabAwareLength;
function checkedRegex(input) {
    try {
        return new RegExp(input, 'g');
    }
    catch (e) {
        return undefined;
    }
}
exports.checkedRegex = checkedRegex;
//# sourceMappingURL=string-utils.js.map