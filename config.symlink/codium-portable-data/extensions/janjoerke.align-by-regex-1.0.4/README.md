# align-by-regex README

With this extension multiple lines of text can be aligned by a regular expression.

## Features

- Align multiple lines of text by regular expressions.
- Store regular expressions as templates for repeated use (Usage: Type the name of the template instead of the regular expression).

## Examples

![Example 1](https://github.com/janjoerke/vscode-align-by-regex/raw/master/images/example1.gif)

![Example 2](https://github.com/janjoerke/vscode-align-by-regex/raw/master/images/example2.gif)

## Extension Settings

This extension contributes the following settings:

* `align.by.regex.templates`: Map which can hold user specified regular expression templates (i.e. `"align.by.regex.templates": { "abc": "=|,|:"}` ).

## Contributors

* [Carl](https://github.com/softwareape)

## Release Notes

### 1.0.4

Fixed an error which could lead to missing spaces in some cases.

### 1.0.3

Fixed an error which could lead to an infinite loop.
Fixed an error, introduced in 1.0.2, which could break alignment in some cases.

### 1.0.2

Multiple alignment isses have been fixed.

### 1.0.1

Minor Bugfixes.

### 1.0.0

Initial release of align-by-regex.
