import Language from "../Language";
import LineOfCode from '../LineOfCode';
import XmlToken from './XmlToken';

export default class XmlLanguage extends Language<XmlToken> {

    protected readonly headOrTailMissingToken: string|undefined = undefined;

    public stringify(columnizedLines: (XmlToken[])[][]): string[]
    {
        throw new Error("Method not implemented.");
    }

    public token2string(token: XmlToken): string
    {
        throw new Error("Method not implemented.");
    }

    public tokenize(linesOfCode: string[]): LineOfCode<XmlToken>[]
    {
        throw new Error("Method not implemented.");
    }

    public preProcessInput(lines: LineOfCode<XmlToken>[]): LineOfCode<XmlToken>[]
    {
        throw new Error("Method not implemented.");
    }

    public preProcessOutput(lines: LineOfCode<XmlToken>[]): LineOfCode<XmlToken>[]
    {
        throw new Error("Method not implemented.");
    }
}
