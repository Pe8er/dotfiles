"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getDefaultThemeOptions = exports.generateThemeConfigurationObject = exports.createThemeFile = void 0;
const workspaceColors_1 = require("../workspaceColors");
const tokenGroups_1 = require("../tokenGroups");
const workspaceColorGenerator_1 = require("./workspaceColorGenerator");
const constants_1 = require("./constants");
const models_1 = require("../../models");
const path = require("path");
const fs = require("fs");
const tokenGenerator_1 = require("./tokenGenerator");
/**
 * Create the JSON file that is responsible for the theme's appearance in the editor.
 */
const createThemeFile = (jsonOptions) => {
    // override the default options with the new options
    const options = Object.assign(Object.assign({}, exports.getDefaultThemeOptions()), jsonOptions);
    const themeJsonPath = path.join(__dirname, '../../../', 'src', constants_1.themeJsonName);
    const json = exports.generateThemeConfigurationObject(options);
    return new Promise((resolve, reject) => {
        fs.writeFile(themeJsonPath, JSON.stringify(json, undefined, 2), (err) => {
            if (err) {
                reject(err);
            }
            else {
                resolve(constants_1.themeJsonName);
            }
        });
    });
};
exports.createThemeFile = createThemeFile;
/**
 * Generate the complete theme configuration object that can be written as JSON file.
 */
const generateThemeConfigurationObject = (options) => {
    const themeConfig = new models_1.ThemeConfiguration();
    themeConfig.options = Object.assign(Object.assign({}, themeConfig.options), options);
    const workspaceColorsConfig = workspaceColorGenerator_1.getWorkspaceColorDefinitions(workspaceColors_1.workspaceColors, themeConfig, options);
    themeConfig.colors = workspaceColorsConfig.colors;
    const tokenColorsConfig = tokenGenerator_1.getTokenStyleDefinitions(tokenGroups_1.tokenGroups, themeConfig, options);
    themeConfig.tokenColors = tokenColorsConfig.tokenColors;
    return themeConfig;
};
exports.generateThemeConfigurationObject = generateThemeConfigurationObject;
/**
 * The options control the generator
 */
const getDefaultThemeOptions = () => ({
    commentItalics: true,
    themeItalics: models_1.ItalicsTheme.More,
    materialize: false
});
exports.getDefaultThemeOptions = getDefaultThemeOptions;
//# sourceMappingURL=jsonGenerator.js.map