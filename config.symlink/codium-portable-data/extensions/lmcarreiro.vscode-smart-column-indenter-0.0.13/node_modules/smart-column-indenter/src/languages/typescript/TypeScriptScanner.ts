import TypeScriptToken from "./TypeScriptToken";
import {
    createScanner,
    Scanner,
    ScriptTarget,
    LanguageVariant,
    SyntaxKind
} from "typescript";

let nestableKinds: [SyntaxKind, SyntaxKind][] = [
    [SyntaxKind.OpenParenToken,   SyntaxKind.CloseParenToken  ],
    [SyntaxKind.OpenBracketToken, SyntaxKind.CloseBracketToken],
    [SyntaxKind.OpenBraceToken,   SyntaxKind.CloseBraceToken  ],
    [SyntaxKind.TemplateHead,     SyntaxKind.TemplateTail     ],
];

export { SyntaxKind, nestableKinds };

export default class TypeScriptScanner
{
    private states: any[];
    private tscScanner: Scanner;
    private lineOfcode: string;

    public constructor(lineOfcode: string)
    {
        this.states = [];
        this.tscScanner = createScanner(ScriptTarget.ES2017, false, LanguageVariant.Standard);
        this.lineOfcode = lineOfcode;

        this.tscScanner.setText(this.lineOfcode);
        
        let tokens = [];

    }

    public getToken(): TypeScriptToken
    {
        this.tscScanner.scan();

        let token = this.tscScanner.getToken();
        let level = this.states.length;

        //TODO: handle regex token

        if (nestableKinds.some(k => token === k[0])) {
            this.states.push(token);
        }
        else if (nestableKinds.some(k => token === k[1])) {
            const state = this.states[this.states.length - 1];

            if (state === SyntaxKind.TemplateHead && token === SyntaxKind.CloseBraceToken) {
                token = this.tscScanner.reScanTemplateToken();
            }

            if (nestableKinds.some(k => state === k[0] && token === k[1])) {
                this.states.pop();
                level--;
            }
        }
        
        return new TypeScriptToken(token, this.tscScanner.getTokenText(), level);
    }

    public endOfLine(): boolean
    {
        return this.tscScanner.getTextPos() === this.lineOfcode.length;
    }
}