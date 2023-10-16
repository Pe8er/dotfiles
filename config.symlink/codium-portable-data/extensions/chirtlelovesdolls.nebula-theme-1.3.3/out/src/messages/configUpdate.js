"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.showConfigUpdateMessages = void 0;
const vscode = require("vscode");
const i18n = require("./../i18N");
const opn = require("opn");
/** User has to confirm if they want to reload the editor */
const showConfigUpdateMessages = () => {
    return new Promise((resolve, reject) => {
        vscode.window.showInformationMessage('Restart VS Code to start using the latest Nebula features', i18n.translate('reload'), i18n.translate('readChangelog'), i18n.translate('reloadAndOpen')).then(value => {
            switch (value) {
                case i18n.translate('reload'):
                    resolve(true);
                    break;
                case i18n.translate('readChangelog'):
                    opn('https://marketplace.visualstudio.com/items/ChirtleLovesDolls.nebula-theme/changelog');
                    break;
                case i18n.translate('reloadAndOpen'):
                    opn('https://marketplace.visualstudio.com/items/ChirtleLovesDolls.nebula-theme/changelog');
                    resolve(true);
                    break;
                default:
                    resolve(false);
                    break;
            }
        });
    });
};
exports.showConfigUpdateMessages = showConfigUpdateMessages;
//# sourceMappingURL=configUpdate.js.map