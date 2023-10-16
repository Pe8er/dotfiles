"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.restoreDefaultConfig = void 0;
const helpers = require("./../helpers");
const index_1 = require("../themes/index");
/** Restore all configurations to default. */
const restoreDefaultConfig = () => {
    const defaultOptions = index_1.getDefaultThemeOptions();
    helpers.setThemeConfig('commentItalics', defaultOptions.commentItalics, true);
    helpers.setThemeConfig('themeItalics', defaultOptions.themeItalics, true);
    helpers.setThemeConfig('materialize', defaultOptions.materialize, true);
};
exports.restoreDefaultConfig = restoreDefaultConfig;
//# sourceMappingURL=restoreConfig.js.map