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
Object.defineProperty(exports, "__esModule", { value: true });
exports.changelogManager = void 0;
const vscode_1 = require("vscode");
const messages_1 = require("../helpers/messages");
class ChangelogManager {
    constructor(message) {
        this.askMessage = message;
    }
    askShowChangelog() {
        return __awaiter(this, void 0, void 0, function* () {
            return (yield vscode_1.window.showInformationMessage(this.askMessage.message, this.askMessage.options.ok, this.askMessage.options.cancel)) === this.askMessage.options.ok;
        });
    }
}
exports.changelogManager = new ChangelogManager(messages_1.MESSAGES.CHANGELOG);
//# sourceMappingURL=changelog-manager.js.map