import { type Node, type Pos } from 'mvdan-sh';
import type { ParserOptions, Plugin } from 'prettier';
import type { File, Node as ShSyntaxNode, ShOptions } from 'sh-syntax';
export interface Processor {
    (text: string, options?: ShOptions): File;
    (text: string, options?: ShOptions & {
        print: true;
    }): string;
    (ast: File, options?: ShOptions & {
        originalText: string;
    }): string;
}
export interface ShParserOptions extends ParserOptions<Node | ShSyntaxNode>, Required<ShOptions> {
    experimentalWasm: boolean;
}
export interface IShParseError extends Error {
    Filename: string;
    Pos: Pos;
    Text: string;
    Incomplete: boolean;
    Error(): void;
}
declare const ShPlugin: Plugin<Node | ShSyntaxNode>;
export default ShPlugin;
