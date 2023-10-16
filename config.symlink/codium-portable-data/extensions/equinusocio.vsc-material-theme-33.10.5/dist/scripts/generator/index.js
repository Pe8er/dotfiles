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
const fs = __importStar(require("fs-extra"));
const path = __importStar(require("path"));
const vscode_theme_generator_1 = require("@moxer/vscode-theme-generator");
const color_set_1 = require("./color-set");
const env_1 = require("../../src/env");
const THEME_BUILD_PATH = path.join(env_1.BUILD_FOLDER_PATH, 'themes');
const themes = ['default', 'darker', 'lighter', 'ocean', 'palenight', 'deepforest'];
const withHC = themes.reduce((acc, src) => {
    acc = acc.concat(`${src}-hc`);
    return acc;
}, themes);
const themeModules = withHC.map((theme) => __awaiter(void 0, void 0, void 0, function* () { return Promise.resolve().then(() => __importStar(require(`./settings/specific/${theme}`))).then(res => res.default); }));
const generate = () => __awaiter(void 0, void 0, void 0, function* () {
    yield fs.mkdirp(THEME_BUILD_PATH);
    const modules = yield Promise.all(themeModules);
    modules.forEach(theme => {
        const colorSet = color_set_1.getColorSet(theme);
        vscode_theme_generator_1.generateTheme(theme.name, colorSet, path.join(THEME_BUILD_PATH, `${theme.name}.json`));
    });
});
const run = () => __awaiter(void 0, void 0, void 0, function* () {
    try {
        yield generate();
    }
    catch (error) {
        console.error('ERROR build:generate-themes', error);
        process.exit(1);
    }
});
void run();
//# sourceMappingURL=index.js.map