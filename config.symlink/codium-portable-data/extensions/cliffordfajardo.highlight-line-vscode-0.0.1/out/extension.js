'use strict';
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
function activate(context) {
    return __awaiter(this, void 0, void 0, function* () {
        /*NOTE: we should only create 1 declaration type object once, as done here.
          If we recreate it in 'updateDecorations' each time, when we removeDecorations,
          they will reference diff objects.
        */
        let decorationType = getDecorationTypeFromConfig();
        let activeEditor = vscode_1.window.activeTextEditor;
        let lastActivePosition;
        /**
         * This is required. When we create a new tab in our editor, we want
         * to update the activeEditor.
         */
        vscode_1.window.onDidChangeActiveTextEditor(() => {
            try {
                activeEditor = vscode_1.window.activeTextEditor;
                updateDecorations(decorationType);
            }
            catch (error) {
                console.error("Error from ' window.onDidChangeActiveTextEditor' -->", error);
            }
            finally {
                lastActivePosition = new vscode_1.Position(activeEditor.selection.active.line, activeEditor.selection.active.character);
            }
        });
        /**
         * Any time we move anywhere around our editor, we want to trigger
         * a decoration.
         */
        vscode_1.window.onDidChangeTextEditorSelection(() => {
            activeEditor = vscode_1.window.activeTextEditor;
            updateDecorations(decorationType);
        });
        /**
         *
         * @param decorationType - defines our decorations settings.
         */
        function updateDecorations(decorationType, updateAllVisibleEditors = false) {
            try {
                if (updateAllVisibleEditors) {
                    vscode_1.window.visibleTextEditors.forEach((editor) => {
                        const currentPosition = editor.selection.active;
                        const currentLine = editor.selection.active.line;
                        const newDecoration = { range: new vscode_1.Range(currentPosition, currentPosition) };
                        editor.setDecorations(decorationType, [newDecoration]);
                    });
                }
                else {
                    vscode_1.window.visibleTextEditors.forEach((editor) => {
                        if (editor !== vscode_1.window.activeTextEditor)
                            return;
                        const currentPosition = editor.selection.active;
                        const editorHasChangedLines = lastActivePosition.line !== currentPosition.line;
                        const isNewEditor = activeEditor.document.lineCount === 1 && lastActivePosition.line === 0 && lastActivePosition.character == 0;
                        const newDecoration = { range: new vscode_1.Range(currentPosition, currentPosition) };
                        if (editorHasChangedLines || isNewEditor) {
                            editor.setDecorations(decorationType, [newDecoration]);
                        }
                    });
                }
            }
            catch (error) {
                console.error("Error from ' updateDecorations' -->", error);
            }
            finally {
                lastActivePosition = new vscode_1.Position(activeEditor.selection.active.line, activeEditor.selection.active.character);
            }
        }
        vscode_1.workspace.onDidChangeConfiguration(() => {
            //clear all decorations
            decorationType.dispose();
            decorationType = getDecorationTypeFromConfig();
            updateDecorations(decorationType, true);
        });
    });
}
exports.activate = activate;
//UTILITIES
function getDecorationTypeFromConfig() {
    const config = vscode_1.workspace.getConfiguration("highlightLine");
    const borderColor = config.get("borderColor");
    const borderWidth = config.get("borderWidth");
    const borderStyle = config.get("borderStyle");
    const decorationType = vscode_1.window.createTextEditorDecorationType({
        isWholeLine: true,
        borderWidth: `0 0 ${borderWidth} 0`,
        borderStyle: `${borderStyle}`,
        borderColor
    });
    return decorationType;
}
// this method is called when your extension is deactivated
function deactivate() {
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map