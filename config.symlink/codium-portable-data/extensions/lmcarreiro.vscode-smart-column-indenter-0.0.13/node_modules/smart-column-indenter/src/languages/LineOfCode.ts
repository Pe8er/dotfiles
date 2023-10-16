import Token from './Token';

type LineOfCode<TokenType extends Token> = TokenType[];

export default LineOfCode;
