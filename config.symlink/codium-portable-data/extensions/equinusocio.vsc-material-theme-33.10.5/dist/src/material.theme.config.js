"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
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
exports.activate = void 0;
const vscode_1 = require("vscode");
const ThemeCommands = __importStar(require("./commands"));
const ReleaseNotes_1 = require("./webviews/ReleaseNotes");
const changelog_manager_1 = require("./core/changelog-manager");
const extension_manager_1 = require("./core/extension-manager");
function activate(context) {
    return __awaiter(this, void 0, void 0, function* () {
        context.globalState.setKeysForSync([extension_manager_1.extensionManager.VERSION_KEY]);
        yield extension_manager_1.extensionManager.init(context);
        const releaseNotesView = new ReleaseNotes_1.ReleaseNotesWebview(context);
        const installationType = extension_manager_1.extensionManager.getInstallationType();
        if ((installationType.firstInstall || installationType.update) && (yield changelog_manager_1.changelogManager.askShowChangelog())) {
            yield releaseNotesView.show();
        }
        // Registering commands
        vscode_1.commands.registerCommand('materialTheme.setAccent', ThemeCommands.setAccent);
        vscode_1.commands.registerCommand('materialTheme.showReleaseNotes', () => __awaiter(this, void 0, void 0, function* () { return releaseNotesView.show(); }));
    });
}
exports.activate = activate;
//# sourceMappingURL=material.theme.config.js.map