"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getWorkspaceColorDefinitions = void 0;
const getWorkspaceColorDefinitions = (wsColors, config, options) => {
    let colors = {};
    wsColors.forEach(wsColor => {
        let setColor;
        if (options.materialize) {
            setColor = wsColor.materialize ? "#0000" /* Transparent */ : wsColor.color;
        }
        else {
            setColor = wsColor.color;
        }
        colors[wsColor.scope] = setColor;
    });
    config.colors = colors;
    return config;
};
exports.getWorkspaceColorDefinitions = getWorkspaceColorDefinitions;
//# sourceMappingURL=workspaceColorGenerator.js.map