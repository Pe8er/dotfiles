"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.reloadWindow = exports.promptToReload = exports.getColorThemeJson = exports.getExtensionPath = exports.isThemeNotVisible = exports.isThemeActivated = exports.setThemeConfig = exports.getThemeConfig = exports.setConfig = exports.getExtensionConfiguration = exports.getConfig = void 0;
const vscode = require("vscode");
const path = require("path");
const fs = require("fs");
const reloadMessages = require("./../messages/reload");
const themes_1 = require("../themes");
/**
 * Get configuration of vs code.
 */
const getConfig = (section) => {
    return vscode.workspace.getConfiguration(section);
};
exports.getConfig = getConfig;
/**
 * Get list of configuration entries of package.json
 */
const getExtensionConfiguration = () => {
    return vscode.extensions.getExtension('ChirtleLovesDolls.nebula-theme').packageJSON.contributes.configuration.properties;
};
exports.getExtensionConfiguration = getExtensionConfiguration;
/**
 * Update configuration of vs code.
 */
const setConfig = (section, value, global = false) => {
    return exports.getConfig().update(section, value, global);
};
exports.setConfig = setConfig;
const getThemeConfig = (section) => {
    return exports.getConfig('nebula-theme').inspect(section);
};
exports.getThemeConfig = getThemeConfig;
/**
 * Set the config of the theme.
 */
const setThemeConfig = (section, value, global = false) => {
    return exports.getConfig('nebula-theme').update(section, value, global);
};
exports.setThemeConfig = setThemeConfig;
/**
 * Is the theme already activated in the editor configuration?
 * @param{boolean} global false by default
 */
const isThemeActivated = (global = false) => {
    let curVal = global ? exports.getConfig().inspect('workbench.colorTheme').globalValue
        : exports.getConfig().inspect('workbench.colorTheme').workspaceValue;
    return (curVal === 'Nebula');
};
exports.isThemeActivated = isThemeActivated;
/**
 * Is the theme not visible for the user?
 */
const isThemeNotVisible = () => {
    const config = exports.getConfig().inspect('workbench.colorTheme');
    return (!exports.isThemeActivated(true) && config.workspaceValue === undefined) || // no workspace and not global
        (!exports.isThemeActivated() && config.workspaceValue !== undefined);
};
exports.isThemeNotVisible = isThemeNotVisible;
/**
 * Return the path of the extension in the file system.
 */
const getExtensionPath = () => path.join(__dirname, '..', '..', '..');
exports.getExtensionPath = getExtensionPath;
/**
 * Get the configuration of the theme as JSON Object
 */
const getColorThemeJson = () => {
    return new Promise((resolve, reject) => {
        const themeJsonPath = path.join(exports.getExtensionPath(), 'out', 'src', themes_1.themeJsonName);
        fs.readFile(themeJsonPath, 'utf8', (err, data) => {
            if (data) {
                resolve(JSON.parse(data));
            }
            else {
                reject(err);
            }
        });
    });
};
exports.getColorThemeJson = getColorThemeJson;
/**
 * Reload vs code window
 */
const promptToReload = () => {
    return reloadMessages.showConfirmToReloadMessage().then(result => {
        if (result) {
            exports.reloadWindow();
        }
    });
};
exports.promptToReload = promptToReload;
const reloadWindow = () => {
    return vscode.commands.executeCommand('workbench.action.reloadWindow');
};
exports.reloadWindow = reloadWindow;
//# sourceMappingURL=index.js.map