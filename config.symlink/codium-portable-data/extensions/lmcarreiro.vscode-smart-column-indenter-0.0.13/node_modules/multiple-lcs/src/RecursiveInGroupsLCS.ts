import BaseLCS from "./BaseLCS";
import Sequence from "./Sequence";

/**
 * This implementation of LCS may not return the Longest Common Subsequence as described in this comment:
 * https://stackoverflow.com/questions/47062351/longest-common-sub-sequence-of-n-sequences-for-diff-purposes#comment81080558_47062543
 * 
 * But with the filter step (implemented in BaseLCS), it may lead to satisfactory results
 */
export default class RecursiveInGroupsLCS extends BaseLCS
{
    protected executeForMoreThanThree(sequences: Sequence[]): Sequence
    {
        const firstTwo = this.execute([sequences[0], sequences[1]]);
        return this.execute([firstTwo, ...sequences.slice(2)]);
    }
}