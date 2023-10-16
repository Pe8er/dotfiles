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
exports.deactivate = exports.activate = void 0;
const vscode = require("vscode");
const plist_file_system_1 = require("./plist-file-system");
const file_1 = require("./file");
function activate(context) {
    let lastClosedPlistXmlPath;
    const document = vscode.workspace.textDocuments[0];
    if (document && document.uri && document.uri.scheme === 'file' && (0, file_1.isBinaryPlist)(document.fileName, document.languageId)) {
        vscode.window.showInformationMessage('This is a binary plist file from a previous session, open it again to make changes.');
    }
    vscode.workspace.registerFileSystemProvider('plist', new plist_file_system_1.PlistFileSystemProvider(), {
        isCaseSensitive: process.platform === 'linux'
    });
    vscode.window.tabGroups.onDidChangeTabs(event => {
        event.closed.forEach(tab => {
            const tabInput = tab.input;
            if (tabInput) {
                if (tabInput.uri.scheme === 'plist') {
                    lastClosedPlistXmlPath = tabInput.uri.path;
                }
                if (tabInput.uri.scheme === 'file') {
                    lastClosedPlistXmlPath = null;
                }
            }
        });
    });
    vscode.workspace.onDidOpenTextDocument((document) => __awaiter(this, void 0, void 0, function* () {
        if (document.uri.scheme === 'plist' || document.uri.path.endsWith('.plist') && !(0, file_1.isBinaryPlist)(document.fileName, document.languageId)) {
            vscode.languages.setTextDocumentLanguage(document, 'xml');
        }
        // after restart this prevents the XML tab from re-opening after closing
        if (lastClosedPlistXmlPath && lastClosedPlistXmlPath === document.fileName) {
            lastClosedPlistXmlPath = null;
            return;
        }
        // after restart this prevents the XML tab from being selected when selecting the binary tab
        const isPlistXmlOpen = vscode.window.tabGroups.activeTabGroup.tabs.filter(tab => tab.input && tab.input.uri.path === document.fileName && tab.input.uri.scheme === 'plist').length === 1;
        if (isPlistXmlOpen && document.uri.scheme === 'file') {
            return;
        }
        if (document.uri.scheme === 'file' && (0, file_1.isBinaryPlist)(document.fileName, document.languageId)) {
            vscode.window.showInformationMessage('Changes to this file will be saved as binary.');
            const uri = vscode.Uri.file(document.fileName).with({ scheme: 'plist' });
            try {
                const doc = yield vscode.workspace.openTextDocument(uri);
                yield vscode.window.showTextDocument(doc, { preview: false });
            }
            catch (error) {
                console.error(error);
            }
        }
    }));
}
exports.activate = activate;
function deactivate() { }
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map