"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.commands = void 0;
const vscode = require("vscode");
const activate_1 = require("./activate");
const restoreConfig_1 = require("./restoreConfig");
// Activate theme
const activateThemeCommand = vscode.commands.registerCommand('nebula-theme.activateTheme', () => {
    activate_1.activateColorTheme();
});
// Reset config
const restoreDefaultConfigCommand = vscode.commands.registerCommand('nebula-theme.restoreDefaultConfig', () => {
    restoreConfig_1.restoreDefaultConfig();
});
exports.commands = [
    activateThemeCommand,
    restoreDefaultConfigCommand
];
//# sourceMappingURL=index.js.map