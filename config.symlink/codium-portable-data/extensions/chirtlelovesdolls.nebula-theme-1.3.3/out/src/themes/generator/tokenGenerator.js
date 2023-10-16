"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getTokenStyleDefinitions = void 0;
const index_1 = require("../../models/index");
const index_2 = require("../TokenGroups/index");
const getTokenStyleDefinitions = (tokenColors, config, options) => {
    const italicTokenDefinitions = setItalicTokenDefinitions(options.commentItalics, options.themeItalics);
    config.tokenColors = [...tokenColors, ...italicTokenDefinitions.tokenColors];
    return config;
};
exports.getTokenStyleDefinitions = getTokenStyleDefinitions;
const setItalicTokenDefinitions = (italicComments, italicsTheme) => {
    let obj = { tokenColors: [] };
    obj.tokenColors = [
        {
            name: 'Compiled Italics',
            scope: [...getItalicScopeArray(italicComments, italicsTheme)],
            settings: { fontStyle: `${index_1.FontStyle.Italics}` }
        }
    ];
    return obj;
};
const getItalicScopeArray = (italicComments, italicsTheme) => {
    let array = [];
    if (italicComments) {
        array = [...array, ...index_2.commentScope];
    }
    if (italicsTheme === index_1.ItalicsTheme.None) {
        return array;
    }
    if (italicsTheme === index_1.ItalicsTheme.Basic) {
        array = [...array, ...index_2.basicScopes];
        return array;
    }
    else if (italicsTheme === index_1.ItalicsTheme.More) {
        array = [...array, ...index_2.basicScopes, ...index_2.moreScopes];
        return array;
    }
    else if (italicsTheme === index_1.ItalicsTheme.Operator) {
        array = [...array, ...index_2.basicScopes, ...index_2.moreScopes, ...index_2.operatorScopes];
        return array;
    }
    else if (italicsTheme === index_1.ItalicsTheme.NoRestraint) {
        array = [...array, ...index_2.basicScopes, ...index_2.moreScopes, ...index_2.operatorScopes, ...index_2.noRestraintScopes];
        return array;
    }
    // Default to Basic Scopes italic theme
    else {
        array = [...array, ...index_2.basicScopes];
        return array;
    }
};
//# sourceMappingURL=tokenGenerator.js.map