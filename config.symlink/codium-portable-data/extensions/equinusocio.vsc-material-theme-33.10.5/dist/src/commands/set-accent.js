"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __rest = (this && this.__rest) || function (s, e) {
    var t = {};
    for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
        t[p] = s[p];
    if (s != null && typeof Object.getOwnPropertySymbols === "function")
        for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
            if (e.indexOf(p[i]) < 0 && Object.prototype.propertyIsEnumerable.call(s, p[i]))
                t[p[i]] = s[p[i]];
        }
    return t;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.command = void 0;
const vscode_1 = require("vscode");
const extension_manager_1 = require("../core/extension-manager");
const settings_manager_1 = require("../core/settings-manager");
const PURGE_KEY = 'Remove accents';
const isValidColor = (color) => color && /^#([0-9A-F]{6}|[0-9A-F]{8})$/i.test(color);
const getThemeColorCustomizationsConfig = (accentColor) => {
    const { accentsProperties } = extension_manager_1.extensionManager.getConfig();
    const color = isValidColor(accentColor) ? accentColor : undefined;
    const themeColorCustomConfig = Object.keys(accentsProperties).reduce((acc, propName) => {
        const currentProp = accentsProperties[propName];
        const shouldModify = color && currentProp.alpha < 100;
        const colorProp = shouldModify ? `${color}${currentProp.alpha > 10 ? currentProp.alpha : `0${currentProp.alpha}`}` : color;
        acc[propName] = colorProp;
        return acc;
    }, {});
    return themeColorCustomConfig;
};
const updateColorCustomizationsConfig = (config) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        yield vscode_1.workspace.getConfiguration().update('workbench.colorCustomizations', config, true);
        return true;
    }
    catch (error) {
        yield vscode_1.window.showErrorMessage(error);
    }
});
const quickPick = () => __awaiter(void 0, void 0, void 0, function* () {
    const themeConfig = extension_manager_1.extensionManager.getConfig();
    const options = Object.keys(themeConfig.accents).concat(PURGE_KEY);
    return vscode_1.window.showQuickPick(options);
});
const command = () => __awaiter(void 0, void 0, void 0, function* () {
    const pkg = extension_manager_1.extensionManager.getPackageJSON();
    const currentThemeID = vscode_1.workspace.getConfiguration().get('workbench.colorTheme');
    const isMaterialTheme = Boolean(pkg.contributes.themes.find(theme => theme.label === currentThemeID));
    if (!isMaterialTheme) {
        return;
    }
    const themeConfig = extension_manager_1.extensionManager.getConfig();
    const currentColorCustomizationsConfig = vscode_1.workspace.getConfiguration().get('workbench.colorCustomizations');
    const accent = yield quickPick();
    let config = {};
    if (accent === PURGE_KEY) {
        const _a = currentColorCustomizationsConfig, _b = currentThemeID, _ = _a[_b], rest = __rest(_a, [typeof _b === "symbol" ? _b : _b + ""]);
        config = rest;
    }
    else {
        config = Object.assign(Object.assign({}, currentColorCustomizationsConfig), { [`[${currentThemeID}]`]: Object.assign({}, getThemeColorCustomizationsConfig(themeConfig.accents[accent])) });
    }
    yield updateColorCustomizationsConfig(config);
    yield settings_manager_1.settingsManager.updateSetting('accent', accent);
});
exports.command = command;
//# sourceMappingURL=set-accent.js.map