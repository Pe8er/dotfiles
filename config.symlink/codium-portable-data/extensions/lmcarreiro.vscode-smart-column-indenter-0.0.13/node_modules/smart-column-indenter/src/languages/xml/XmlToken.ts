import Token from "../Token";

export default class XmlToken extends Token {
    constructor(kind: TokenType, content: string)
    {
        super(kind, content, 0);
    }
}

type TokenType = "start-tag"  // <XXX
               | "end-tag"    // </XXX
               | "tag-close"  // >
               | "attribute"
               | "equal"
               | "attrivuteValue"
               | "innerContent"
               ;
