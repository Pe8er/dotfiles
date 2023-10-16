# Auto Align

![video](https://raw.githubusercontent.com/Gruntfuggly/auto-align/master/auto-align.gif)

This is basically a poor man's spreadsheet. It auto formats a file, aligning columns by padding with spaces. It uses commas for .csv files and vertical bars for .bsv files. You can also add other separators for other file types if you want.

It will find the first and last lines in the file containing the separator and format all lines between.

When active, the tab key will move to the next field and shift+tab will move to the previous field.

Alignment can also be triggered manually using `Auto Align: Align Columns`, `Auto Align: Align Selection` or `Auto Align: Align Selection With Separator`.

*Note: This works well with reasonably small files. With a 2000 line, 10 column file it's still usable. With 10000 lines it starts to lag a bit. I wrote this because I often feel the need to write files in a simple table format, but don't want to use Excel. **You may want to take a copy of your file first, just to be safe**.*

- [ ] Highlight headings in bold (or something)
- [ ] Add sort functionality
- [ ] Add warning if file already contains new separator
- [ ] Add methods to insert/remove empty columns

## Installing

You can install the latest version of the extension via the Visual Studio Marketplace [here](https://marketplace.visualstudio.com/items?itemName=Gruntfuggly.auto-align).

Alternatively, open Visual Studio code, press `Ctrl+P` or `Cmd+P` and type:

    > ext install auto-align

### Source Code

The source code is available on GitHub [here](https://github.com/Gruntfuggly/auto-align).

## Configuration

`autoAlign.associations`

This defines which files will be auto aligned, and what separator to use. By default it sets .csv files to commas, and .bsv files to vertical bars. The separator is used as part of a regex. Single character separators are automatically escaped, but if you need a more complicated separator, you may need to escape other characters.

The separator for the current file type can be changed with the **'Auto Align: Change Separator'** command.

`autoAlign.enabled`

Set this to false to disable auto formatting for the associated file extension.

This flag can be set using the command **'Auto Align: Enable auto align mode'** and **'Auto Align: Disable auto align mode'**. Alternatively, it can be quickly changed by clicking the **'Auto Align'** button on the status bar.

`autoAlign.delay`

This is the delay after which the file is formatted when you stop typing.

`autoAlign.dimSeparator`

When auto align is enabled, the separators are dimmed to aid readability. Set this to false if you would prefer not to dim them.

`autoAlign.collapseOnDisable`

If set to true, the fields will all be collapsed (spaces trimmed) when auto align is disabled. The file can also be collapsed manually using the **'Auto Align: Format'** command if auto align is not enabled.

`autoAlign.extraSpace`

By default, an extra space is inserted after the separator to aid readability. If you don't want this, set this flag to false.

`autoAlign.endingSeparator`

Set to true add an aligned trailing separator.

`autoAlign.repositionCursor`

Normally, after formatting, an attempt is made to reposition the cursor somewhere sensible. If this gets annoying, you can disable this by setting this to false.

## Credits

I shamelessly stole the alignment code from [dakara](https://marketplace.visualstudio.com/publishers/dakara)'s [Transformer](https://marketplace.visualstudio.com/items?itemName=dakara.transformer) extension.

Icon from [deleket](http://www.softicons.com/designers/deleket).

Regex for matching separators unless quoted by Stack Overflow user [hwnd](https://stackoverflow.com/users/2206004/hwnd).
