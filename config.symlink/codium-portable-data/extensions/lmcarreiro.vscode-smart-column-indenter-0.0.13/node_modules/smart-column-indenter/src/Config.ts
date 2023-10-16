export default interface IndenterConfig {
    languageExtensionsMap: { [language: string]: Extensions }
}

type Extensions = string[];
