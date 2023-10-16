"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ReleaseNotesWebview = void 0;
const Webview_1 = require("./Webview");
class ReleaseNotesWebview extends Webview_1.WebviewController {
    get filename() {
        return 'release-notes.html';
    }
    get id() {
        return 'materialTheme.releaseNotes';
    }
    get title() {
        return 'Material Theme Release Notes';
    }
    /**
     * This will be called by the WebviewController when init the view
     * passing as `window.bootstrap` to the view.
     */
    getBootstrap() {
        return {};
    }
}
exports.ReleaseNotesWebview = ReleaseNotesWebview;
//# sourceMappingURL=ReleaseNotes.js.map