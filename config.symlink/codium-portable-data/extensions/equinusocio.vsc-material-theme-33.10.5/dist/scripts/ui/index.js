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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const fs = __importStar(require("fs-extra"));
const path = __importStar(require("path"));
const browserify_1 = __importDefault(require("browserify"));
const env_1 = require("../../src/env");
const UI_FOLDER_PATH = path.join(env_1.SRC_FOLDER_PATH, 'webviews', 'ui');
const UI_JS_FOLDER_PATH = path.join(env_1.TS_BUILD_FOLDER_PATH, 'src', 'webviews', 'ui');
const UI_FOLDER_BUILD_PATH = path.join(env_1.BUILD_FOLDER_PATH, 'ui');
const copyStatics = () => __awaiter(void 0, void 0, void 0, function* () {
    const paths = [{
            src: path.join(UI_FOLDER_PATH, 'release-notes', 'release-notes.html'),
            dest: path.join(UI_FOLDER_BUILD_PATH, 'release-notes.html')
        }, {
            src: path.join(UI_FOLDER_PATH, 'release-notes', 'style.css'),
            dest: path.join(UI_FOLDER_BUILD_PATH, 'release-notes.css')
        }];
    return Promise.all(paths.map((path) => __awaiter(void 0, void 0, void 0, function* () { return fs.copyFile(path.src, path.dest); })));
});
const buildJs = (type) => __awaiter(void 0, void 0, void 0, function* () {
    const jsBuildPath = path.join(UI_FOLDER_BUILD_PATH, `${type}.js`);
    const b = browserify_1.default();
    yield fs.createFile(jsBuildPath);
    const jsBuildFileStream = fs.createWriteStream(jsBuildPath);
    b.add(path.join(UI_JS_FOLDER_PATH, type, 'index.js'));
    b.bundle().pipe(jsBuildFileStream);
    return Promise.resolve();
});
const run = () => __awaiter(void 0, void 0, void 0, function* () {
    try {
        yield fs.mkdirp(UI_FOLDER_BUILD_PATH);
        yield copyStatics();
        yield buildJs('release-notes');
    }
    catch (error) {
        console.error('ERROR build:ui:', error);
        process.exit(1);
    }
});
run();
//# sourceMappingURL=index.js.map