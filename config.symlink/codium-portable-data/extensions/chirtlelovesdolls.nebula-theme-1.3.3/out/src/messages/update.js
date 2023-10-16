"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.showUpdateMessage = void 0;
const helpers = require("./../helpers");
const vscode = require("vscode");
const opn = require("opn");
const i18n = require("./../i18N");
const activate_1 = require("../commands/activate");
/** Show the update message if the icon theme has been updated. */
const showUpdateMessage = () => {
    vscode.window.showInformationMessage(i18n.translate('themeUpdated'), 
    // show 'Activate' button if icon theme is not active
    helpers.isThemeNotVisible()
        ? i18n.translate('activate') : undefined, i18n.translate('readChangelog')).then(handleUpdateMessageActions);
};
exports.showUpdateMessage = showUpdateMessage;
/** Handle the actions of the update message. */
const handleUpdateMessageActions = (value) => {
    switch (value) {
        case i18n.translate('activate'):
            activate_1.activateColorTheme();
            break;
        case i18n.translate('readChangelog'):
            opn('https://marketplace.visualstudio.com/items/ChirtleLovesDolls.nebula-theme/changelog');
            break;
        default:
            break;
    }
};
//# sourceMappingURL=update.js.map