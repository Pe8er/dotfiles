# Binary Plist

A Visual Studio Code extension that enables editing of binary property list files as XML. It is inspired by the [BinaryPlist](https://github.com/tyrone-sudeium/st3-binaryplist) Sublime Text package, although the experience is not as seamless (the user must agree to opening a binary file and the editing takes place in an additional tab). A virtual file system is used to achieve this using the `FileSystemProvider` API.

The extension is cross-platform but primarily uses the macOS `plutil` binary for conversion, the Python `plistlib` is used as an alternative if available. The node package `simple-plist` is used as a fallback but due to JavaScript not having a float type `real` values that are whole numbers will be cast to `integer` types (a warning dialog is shown first).

## Usage

Simply open a binary property list file and after clicking the "Open Anyway" button and choosing the default "Text Editor" editor from the list another tab will open in XML and all changes saved will be reflected in the other tab as binary.

If Visual Studio Code does not recognize the file as a `plist` file select it as the language mode. File associations can be used to perform this when a file is opened, the following settings code will associate `.strings` files:

```javascript
  "files.associations": {
​      "*.strings": "plist"
  }
```

## Tests

Tests can be run with `npm test` or running `Extension Tests` in the Visual Studio Code debugger.
