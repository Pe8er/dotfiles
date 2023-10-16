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
exports.WebviewController = void 0;
const path = __importStar(require("path"));
const vscode_1 = require("vscode");
class WebviewController extends vscode_1.Disposable {
    constructor(context) {
        // Applying dispose callback for our disposable function
        super(() => this.dispose());
        this.context = context;
    }
    dispose() {
        if (this.disposablePanel) {
            this.disposablePanel.dispose();
        }
    }
    show() {
        return __awaiter(this, void 0, void 0, function* () {
            const html = yield this.getHtml();
            // If panel already opened just reveal
            if (this.panel !== undefined) {
                // Replace placeholders in html content for assets and adding configurations as `window.bootstrap`
                const fullHtml = this.replaceInPanel(html);
                this.panel.webview.html = fullHtml;
                return this.panel.reveal(vscode_1.ViewColumn.Active);
            }
            this.panel = vscode_1.window.createWebviewPanel(this.id, this.title, vscode_1.ViewColumn.Active, {
                retainContextWhenHidden: true,
                enableFindWidget: true,
                enableCommandUris: true,
                enableScripts: true
            });
            // Applying listeners
            this.disposablePanel = vscode_1.Disposable.from(this.panel, this.panel.onDidDispose(this.onPanelDisposed, this), this.panel.onDidChangeViewState(this.onViewStateChanged, this), this.panel.webview.onDidReceiveMessage(this.onMessageReceived, this));
            // Replace placeholders in html content for assets and adding configurations as `window.bootstrap`
            const fullHtml = this.replaceInPanel(html);
            this.panel.webview.html = fullHtml;
        });
    }
    onMessageReceived(event) {
        if (event === null) {
            return;
        }
        console.log(`WebviewEditor.onMessageReceived: type=${event.type}, data=${JSON.stringify(event)}`);
        switch (event.type) {
            case 'saveSettings':
                // TODO: update settings
                break;
            default:
                break;
        }
    }
    replaceInPanel(html) {
        // Replace placeholders in html content for assets and adding configurations as `window.bootstrap`
        const fullHtml = html
            .replace(/{{root}}/g, this.panel.webview.asWebviewUri(vscode_1.Uri.file(this.context.asAbsolutePath('./build'))).toString())
            .replace(/{{cspSource}}/g, this.panel.webview.cspSource)
            .replace('\'{{bootstrap}}\'', JSON.stringify(this.getBootstrap()));
        return fullHtml;
    }
    getHtml() {
        return __awaiter(this, void 0, void 0, function* () {
            const doc = yield vscode_1.workspace
                .openTextDocument(this.context.asAbsolutePath(path.join('build/ui', this.filename)));
            return doc.getText();
        });
    }
    // Private async postMessage(message: Message, invalidates: Invalidates = 'all'): Promise<boolean> {
    //   if (this.panel === undefined) {
    //     return false;
    //   }
    //   const result = await this.panel.webview.postMessage(message);
    //   // If post was ok, update invalidateOnVisible if different than default
    //   if (!result && this.invalidateOnVisible !== 'all') {
    //     this.invalidateOnVisible = invalidates;
    //   }
    //   return result;
    // }
    // Private async postUpdatedConfiguration(): Promise<boolean> {
    //   // Post full raw configuration
    //   return this.postMessage({
    //     type: 'settingsChanged',
    //     config: getCustomSettings()
    //   } as ISettingsChangedMessage, 'config');
    // }
    onPanelDisposed() {
        if (this.disposablePanel) {
            this.disposablePanel.dispose();
        }
        this.panel = undefined;
    }
    onViewStateChanged(event) {
        return __awaiter(this, void 0, void 0, function* () {
            console.log('WebviewEditor.onViewStateChanged', event.webviewPanel.visible);
            if (!this.invalidateOnVisible || !event.webviewPanel.visible) {
                return;
            }
            // Update the view since it can be outdated
            const invalidContext = this.invalidateOnVisible;
            this.invalidateOnVisible = undefined;
            switch (invalidContext) {
                case 'config':
                    // Post the new configuration to the view
                    // return this.postUpdatedConfiguration();
                    return;
                default:
                    return this.show();
            }
        });
    }
}
exports.WebviewController = WebviewController;
//# sourceMappingURL=Webview.js.map