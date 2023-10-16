# Change Log

## Releases

### 0.0.13
Addressed an issue raised by @gsabater where he was trying to make `=>` moveable. Turned out that it highlighted 2 issues:
* adding something to the `moveable` lists will now override the fact that they are in the `non-moveable` lists.
* auto-aligner will now sort the moveable and non-moveable keys it looks for by length. This way it will first find `=>` instead of stopping at `=`.

### 0.0.11
* Corrected for when a line had multiple moveable items in it. The extension was using the _last found_ moveable item rather than the item _nearest_ to the front of the line.

### 0.0.10
* Fixed an issue where it stopped after finding the _first_ non-movable item instead of looking through all of them and finding the farthest-left.
* Added back-tick to non-moveable list. Templates were getting hammered.

### 0.0.9
* Added example screenshot
* Added '[' to line skip defaults

### 0.0.8
* Added ability to skip lines that end in certain patterns. This is most useful to me in something like CSS or JSON where I don't want the block-assignment to be aligned, but 
I do for the rules.

### 0.0.6
* Fixed an issue where if a line had more than 1 moveable item it would move the first, but replace it with the last. Ugly.
* Added changelog

### 0.0.5
* Fixed an issue where very short lines were not aligning quite right

### 0.0.4
* Big improvements around customization. Also will now re-align already aligned areas.

### 0.0.1
* Initial release