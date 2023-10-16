# DreadAlign README

DreadAlign is a simple code and text alignment extension that attempts to bring
a great deal of power to you in a very small package. Styled after similar
extensions like EasyAlign for vim, it attempts to bring that level of control
to vscode alignment.

## Features

Allows alignment based on arbitrary characters.

# Usage

Once the extension is loaded, you need simply highlight the range of text you
wish to format and use the command "DreadAlign: Align Text". It will then ask
you for the character (or characters) you wish to use as the "delimiter," and
begin splitting the lines at these characters. The split ranges will be
space-padded such that they align.

## Known Issues

Currently, there is much work left to be done but it is functional enough I use
it daily. Currently I plan to add support for formatting only 1 instance of
the delimiters.

## TODO

* Add support for "common" delimiters without specifying at run time (',', '=', etc), and allow them to be keybindable
* Add support for "table" mode ala Emacs / OrgMode
* Add support for regular expressions as a delimiter

## Release Notes

### 0.0.3

* Excensive refactoring of the code
* Initial support for pre- and post-pending of text on delimiter
* As the prepend, postpend and delimiter are now defined in the workspace configuration, you can set-and-forget these per project.

### 0.0.2

* Enhancements to the formatting logic
* Support for indented selections starting in the middle of the line

### 0.0.1

* Initial release
