import Config from "../Config";
import Language from "./Language";
import Token from "./Token";

import TypeScriptLanguage from "./typescript/TypeScriptLanguage";
import XmlLanguage from "./xml/XmlLanguage";

export default class LanguageFactory
{
    public static getLanguage(config: Config, extension: string): Language<Token>
    {
        const name = LanguageFactory.getLanguageName(config, extension);

        switch (name) {
            case "TypeScript": return new TypeScriptLanguage();
            case "Xml": return new XmlLanguage();
            default: throw new Error(`Language '${name}' doesn't exist.`);
        }
    }

    private static getLanguageName(config: Config, extension: string): string
    {
        for (const language in config.languageExtensionsMap) {
            if (config.languageExtensionsMap[language].indexOf(extension) > -1) {
                return language;
            }
        }

        //TODO: while we don't have other languages yet, lets try to scan it using TypeScript scanner for now
        return "TypeScript";

        //throw new Error(`Extension '${extension}' is not mapped to any Language.`);
    }
}
