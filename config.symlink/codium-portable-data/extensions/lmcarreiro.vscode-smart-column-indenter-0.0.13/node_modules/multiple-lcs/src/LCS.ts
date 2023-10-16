import BaseLCS from "./BaseLCS";
import Sequence from "./Sequence";
import RecursiveInGroupsLCS from "./RecursiveInGroupsLCS";
import IncrementalIntersectionLCS from "./IncrementalIntersectionLCS";

export default class LCS
{
    private lcsResolvers: BaseLCS[] = [];

    //TODO: accept configs of how resolvers to use (default to use all of them)
    public constructor()
    {
        this.lcsResolvers.push(new RecursiveInGroupsLCS());
        this.lcsResolvers.push(new IncrementalIntersectionLCS());
    }

    public execute(sequences: Sequence[]): Sequence
    {
        const solutions = this.lcsResolvers
            .map(lcs => lcs.execute(sequences))
            .sort((a, b) => b.length - a.length);

        return solutions[0];
    }
}