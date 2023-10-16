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
Object.defineProperty(exports, "__esModule", { value: true });
exports.MATERIAL_THEME_EXT_ID = exports.USER_CONFIG_FILE_NAME = exports.CONFIG_FILE_NAME = exports.TS_BUILD_FOLDER_PATH = exports.BUILD_FOLDER_PATH = exports.SRC_FOLDER_PATH = void 0;
const path = __importStar(require("path"));
exports.SRC_FOLDER_PATH = path.resolve('./src');
exports.BUILD_FOLDER_PATH = path.resolve('./build');
exports.TS_BUILD_FOLDER_PATH = path.resolve('./dist');
exports.CONFIG_FILE_NAME = 'material-theme.config.json';
exports.USER_CONFIG_FILE_NAME = 'user.material-theme.config.json';
exports.MATERIAL_THEME_EXT_ID = 'equinusocio.vsc-material-theme';
//# sourceMappingURL=env.js.map