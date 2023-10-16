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
exports.PlistFileSystemProvider = void 0;
const vscode = require("vscode");
const util = require("util");
const plist_file_format_1 = require("./plist-file-format");
class PlistFileSystemProvider {
    constructor() {
        this.onDidChangeFile = new vscode.EventEmitter().event;
    }
    readFile(uri) {
        const plistFileFormat = new plist_file_format_1.PlistFileFormat;
        const xmlString = plistFileFormat.binaryToXml(uri.fsPath);
        const stringArray = new util.TextEncoder().encode(xmlString);
        return stringArray;
    }
    writeFile(uri, content, options) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const xmlString = new util.TextDecoder().decode(content);
                const plistFileFormat = new plist_file_format_1.PlistFileFormat;
                yield plistFileFormat.xmlToBinary(uri.fsPath, xmlString);
                vscode.window.showInformationMessage('Plist file successfully saved.');
            }
            catch (error) {
                vscode.window.showErrorMessage(`An error occurred saving the file: ${error}`);
            }
        });
    }
    stat(uri) {
        return ({ type: vscode.FileType.File });
    }
    createDirectory(uri) { }
    delete(uri, options) { }
    readDirectory(uri) { return []; }
    rename(oldUri, newUri, options) { }
    watch(uri, options) { return new vscode.Disposable(() => { }); }
}
exports.PlistFileSystemProvider = PlistFileSystemProvider;
//# sourceMappingURL=plist-file-system.js.map