# Auto-Align

This is an alignment utility that allows for a bit of customization. It will line up assignment operators (`=` and `:` by default) in selected text.

![Example](https://github.com/bladnman/auto-align/raw/master/images/example.gif)

## Features

_Still working on it... I use it daily so it works, but always finding little things. Send me an issue on GitHub if you are looking for something or something doesn't work._

This system will *not* alter any lines where any of the `non-moveable` items are found to the left of a moveable item.

It is likely you will find scenarios where this does not quite fit your needs with advanced CSS selectors and the likes. You get to set the `moveable` and `non-moveable` in your personal settings file.

You can also define a minimum amount of space you want to see on the left of the moveable items. This is essentially the margin.

```
x = 12;
name = "Dexter";
```
[BECOMES]
```
x      = 12;
name   = "Dexter";
```

You get the idea. This can be done in any language format.


## Extension Settings

This extension contributes the following settings:

### Additional Lists
Use these settings to "add" to the default lists in the extension so that you don't have to repeat the whole original list.

| setting name                                       | description      |
| -------------------------------------------------- |------------------|
| `autoalign.moveableItemsAdditional`                | Items you want **added** to the default list of **moveable items**
| `autoalign.nonMoveableItemsAdditional`             | Items you want **added** to the default list of **non-moveable items**
| `autoalign.skipLinesEndingWithItemsAdditional`     | Lines to not be aligned if they **end** with these items


### Properties
Some parameters to define how things lay out.

| setting name                   | description      |
| ------------------------------ |------------------|
| `autoalign.minSeparationLeft`  |  Minimum amount of white-space placed **before** the aligned items
| `autoalign.separationRight`    |  The number of spaces you want after the aligned item (e.g. spaces to the right of the equals)
| `autoalign.columnWidth`        |   If this is > 1 then all alignments will be matched up to imaginary columns of this width


### Default Lists
You can also override the original default list to be in complete control of all moveable and non-moveable items.

| setting name                                    | description      |
| ----------------------------------------------- |------------------|
| `autoalign.moveableItems`                       | An array of strings of the items which can be moved and aligned
| `autoalign.nonMoveableItems`                    |  An array of string which cannot be moved and will prevent a line from being aligned
| `autoalign.skipLinesEndingWithItemsAdditional`  |  An array of string which cannot be moved and will prevent a line from being aligned

