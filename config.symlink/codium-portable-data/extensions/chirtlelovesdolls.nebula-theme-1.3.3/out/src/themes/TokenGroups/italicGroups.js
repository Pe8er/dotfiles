"use strict";
/**
 * Each scope should only be referenced a SINGLE time across all of the
 * arrays in this file. This is to make maintaining the italic variants
 * easier.
 *
 * Also, please keep everything in alphabetical order :D
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports.setCommentItalicsObject = exports.noRestraintScopes = exports.operatorScopes = exports.moreScopes = exports.basicScopes = exports.commentScope = void 0;
exports.commentScope = [
    "comment"
];
/**
 * 1 - Basic
 */
exports.basicScopes = [
    "entity.other.attribute-name.pseudo-element.css",
    "entity.other.inherited-class",
    "markup.italic.markdown",
    "markup.quote",
    "meta.function.variable.css",
    "punctuation.definition.italic.markdown",
    "punctuation.definition.string.css",
    "storage.type.function",
    "string.quoted.double.css",
    "variable.argument.css"
];
/**
 * 2 - Wavy
 */
exports.moreScopes = [
    "entity.name.tag.custom",
    "entity.name.type.ts",
    "italic",
    "keyword.operator.type.annotation",
    "keyword.control.import",
    "modifier",
    "punctuation.section.embedded",
    "quote",
    "storage.type",
    "storage.type.class",
    "support.class",
    "support.class.builtin",
    "support.constant",
    "support.function.basic_functions",
    "support.function.builtin",
    "support.type.primitive",
    "support.type.property.css",
    "this",
    "type.function",
    "variable.parameter"
];
/**
 * 3 - Curly
 */
exports.operatorScopes = [
    "constant.language",
    "constant.other.color.rgb-value.hex.css",
    "constant.other.rgb-value.css",
    "entity.name.tag.doctype",
    "entity.name.tag.yaml",
    "keyword.control",
    "keyword.operator.expression.typeof",
    "language",
    "meta.parameter",
    "meta.parameters",
    "meta.tag.sgml.doctype",
    "meta.tag.sgml.doctype.html",
    "meta.var.expr storage.type",
    "parameter",
    "source.js.jsx keyword.control.flow.js",
    "storage",
    "support.constant.math",
    "support.type.vendored.property-name.css",
    "type.var",
    "variable.language",
    "variable.object.property.js",
    "variable.object.property.jsx",
    "variable.object.property.ts",
    "variable.object.property.tsx",
    "variable.other.less",
    "variable.parameter.url.sass",
    "variable.parameter.url.scss",
    "variable.sass",
    "variable.scss"
];
/**
 * 4 - No Restraint
 */
exports.noRestraintScopes = [
    ".type",
    "constant.character",
    "constant.other",
    "emphasis",
    "entity.name.function.ts",
    "entity.name.function.tsx",
    "entity.name.tag.script.html",
    "entity.other.attribute-name",
    "entity.other.attribute-name.pseudo-class.css",
    "entity.other.attribute-name.pseudo-selector.css",
    "entity.other.inherited-class entity.name.type.module",
    "entity.other.less.mixin",
    "keyword",
    "markup.italic",
    "meta.diff",
    "meta.diff.header",
    "meta.export.js variable.other",
    "meta.import.js variable.other",
    "meta.export.ts meta.block.ts variable.other.readwrite.alias.ts",
    "meta.export.tsx meta.block.tsx variable.other.readwrite.alias.tsx",
    "meta.import.ts meta.block.ts variable.other.readwrite.alias.ts",
    "meta.import.tsx meta.block.tsx variable.other.readwrite.alias.tsx",
    "meta.object-literal.key",
    "meta.selector.css entity.other.attribute-name.class",
    "punctuation.definition.blockquote.markdown",
    "punctuation.definition.comment",
    "source.json meta.structure.dictionary support.type.property-name.json",
    "source.java storage.type.annotation",
    "storage.modifier",
    "storage.type",
    "storage.type.annotation",
    "storage.type.class.js",
    "string",
    "string.quoted.docstring",
    "string.regexp",
    "support.constant.vendored.property-value.css",
    "support.module",
    "support.node",
    "support.type",
    "support.type.property-name.css",
    "text.html.markdown",
    "variable.language.this",
    "variable.language.this.js"
];
const setCommentItalicsObject = (enabled = true) => {
    if (!enabled) {
        return { tokenColors: [] };
    }
    let obj = { tokenColors: [] };
    if (enabled) {
        obj.tokenColors = [
            {
                name: 'comment',
                scope: ['comment'],
                settings: { fontStyle: 'italic' }
            }
        ];
    }
    return obj;
};
exports.setCommentItalicsObject = setCommentItalicsObject;
//# sourceMappingURL=italicGroups.js.map