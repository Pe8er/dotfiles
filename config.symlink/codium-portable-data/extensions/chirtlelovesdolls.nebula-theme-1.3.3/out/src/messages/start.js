"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.showStartMessages = void 0;
const update_1 = require("./update");
const welcome_1 = require("./welcome");
const configUpdate_1 = require("./configUpdate");
const versioning_1 = require("../helpers/versioning");
const helpers_1 = require("../helpers");
/** Initialization of the colors every time the theme get activated */
const showStartMessages = (themeStatus) => {
    return themeStatus.then((status) => {
        if (status === versioning_1.ThemeStatus.updated) {
            update_1.showUpdateMessage();
        }
        else if (status === versioning_1.ThemeStatus.neverUsedBefore) {
            welcome_1.showWelcomeMessage();
        }
        else if (status === versioning_1.ThemeStatus.firstConfigurable) {
            configUpdate_1.showConfigUpdateMessages().then(() => {
                helpers_1.reloadWindow();
            });
        }
    });
};
exports.showStartMessages = showStartMessages;
//# sourceMappingURL=start.js.map