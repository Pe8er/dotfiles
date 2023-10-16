"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.yellow = exports.green = exports.red = void 0;
// colored console output
const red = (value) => `\x1b[35m${value}\x1b[0m`;
exports.red = red;
const green = (value) => `\x1b[36m${value}\x1b[0m`;
exports.green = green;
const yellow = (value) => `\x1b[33m${value}\x1b[0m`;
exports.yellow = yellow;
//# sourceMappingURL=painter.js.map