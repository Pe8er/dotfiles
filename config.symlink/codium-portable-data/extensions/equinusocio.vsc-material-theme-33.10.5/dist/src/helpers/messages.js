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
exports.installationMessage = exports.MESSAGES = void 0;
const vscode_1 = require("vscode");
exports.MESSAGES = {
    CHANGELOG: {
        message: 'Material Theme was updated. Check the release notes for more details.',
        options: { ok: 'Show me', cancel: 'Maybe later' }
    },
    INSTALLATION: {
        message: 'Thank you for using Material Theme!'
    }
};
const installationMessage = () => __awaiter(void 0, void 0, void 0, function* () {
    return vscode_1.window.showInformationMessage(exports.MESSAGES.INSTALLATION.message);
});
exports.installationMessage = installationMessage;
//# sourceMappingURL=messages.js.map