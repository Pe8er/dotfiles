import Language from './languages/Language';
import Token from './languages/Token';

/**
 * Split each line of the input into columns.
 * This method returns a 3D matrix as an array of lines.
 * Each line is an array os columns.
 * Each line/column position has an array os tokens.
 */
export default class Columnizer
{
    private readonly language: Language<Token>;
    private readonly commonTokens: string[];
    private readonly originalLines: Token[][];

    private readonly columnizedLines: (Token[])[][];
    private readonly actualTokenByLine: number[];
    private          actualColumn: number;

    constructor(language: Language<Token>, commonTokens: string[], originalLines: Token[][])
    {
        this.language = language;
        this.commonTokens = commonTokens;
        this.originalLines = originalLines;

        this.columnizedLines = this.originalLines.map(line => []);
        this.actualTokenByLine = this.originalLines.map(line => -1);
        this.actualColumn = -1;
    }

    public columnize(): (Token[])[][]
    {
        this.addColumn();

        for (const commonToken of this.commonTokens) {
            this.copyUntil(commonToken);
            this.addColumn();
            this.copyOnce();
            this.addColumn();
        }

        this.copyUntil();

        return this.columnizedLines;
    }

    /**
     * Adds a new column in the matrix of columnized list tokens
     */
    private addColumn(): void
    {
        this.actualColumn++;
        this.columnizedLines.forEach(columnizedLine => columnizedLine[this.actualColumn] = []);
    }

    /**
     * Gets the next token of the line
     */
    private nextToken(lineNumber: number): Token|undefined
    {
        this.actualTokenByLine[lineNumber]++;
        return this.actualToken(lineNumber);
    }

    /**
     * Gets the next token of the line
     */
    private actualToken(lineNumber: number): Token|undefined
    {
        return this.originalLines[lineNumber][this.actualTokenByLine[lineNumber]];
    }

    /**
     * Copy values from original lines to the actual column of the columnized lines until it finds the end of each original line
     */
    private copyUntil(): void;
    /**
     * Copy values from original lines to the actual column of the columnized lines until it finds the tokenContent in the original lines
     */
    private copyUntil(tokenContent: string): void;
    private copyUntil(tokenContent?: string): void
    {
        for (let lineNumber = 0; lineNumber < this.originalLines.length; lineNumber++) {
            let token = this.nextToken(lineNumber);
            while(token && (tokenContent === undefined || tokenContent !== this.language.token2string(token)))
            {
                this.columnizedLines[lineNumber][this.actualColumn].push(token);
                token = this.nextToken(lineNumber);
            }
        }
    }

    private copyOnce(): void
    {
        for (let lineNumber = 0; lineNumber < this.originalLines.length; lineNumber++) {
            let token = this.actualToken(lineNumber);
            if (token) {
                this.columnizedLines[lineNumber][this.actualColumn].push(token);
            }
            else {
                throw new Error("There are no more tokens to copy.");
            }
        }
    }
}