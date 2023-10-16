export default abstract class Token
{
    public kind: TokenType;
    public content: string;
    public level: number;

    constructor(kind: TokenType, content: string, level: number)
    {
        this.kind = kind;
        this.content = content;
        this.level = level;
    }
}

type TokenType = string;
