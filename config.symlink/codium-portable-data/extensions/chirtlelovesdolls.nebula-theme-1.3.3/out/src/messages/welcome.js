"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.showWelcomeMessage = void 0;
const helpers = require("./../helpers");
const vscode = require("vscode");
const opn = require("opn");
const i18n = require("./../i18N");
const activate_1 = require("../commands/activate");
/** Show the welcome message if the color theme has been installed the first time. */
const showWelcomeMessage = () => {
    vscode.window.showInformationMessage(i18n.translate('themeInstalled'), 
    // show 'Activate' button if icon theme is not active
    helpers.isThemeNotVisible() ? i18n.translate('activate') : i18n.translate('howToActivate')).then(handleWelcomeMessageActions);
};
exports.showWelcomeMessage = showWelcomeMessage;
/** Handle the actions of the welcome message. */
const handleWelcomeMessageActions = (value) => {
    switch (value) {
        case i18n.translate('activate'):
            activate_1.activateColorTheme();
            break;
        case i18n.translate('howToActivate'):
            opn('https://code.visualstudio.com/docs/getstarted/themes#_selecting-the-color-theme');
            break;
        default:
            break;
    }
};
//# sourceMappingURL=welcome.js.map