// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
const vscode = require('vscode');

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
function activate(context) {

    // The command has been defined in the package.json file
    // Now provide the implementation of the command with  registerCommand
    // The commandId parameter must match the command field in package.json
    let disposable = vscode.commands.registerCommand('extension.autoalign', function () {
      const aligner                       = new Aligner();
      aligner.movableItemsList            = getMoveableItemsArray();
      aligner.nonMovableItemsList         = getNonMoveableItemsArray();
      aligner.skippableEndingItemsArray   = getSkippableEndingItemsArray();
      aligner.minSeparationLeft           = vscode.workspace.getConfiguration().get('autoalign.minSeparationLeft');
      aligner.separationRight             = vscode.workspace.getConfiguration().get('autoalign.separationRight');
      aligner.columnWidth                 = vscode.workspace.getConfiguration().get('autoalign.columnWidth');
      let editor                          = vscode.window.activeTextEditor;
      let selections                      = editor.selections; // handle multiple selections the same

      if ( ! isSomethingSelected(editor) ) {
        vscode.window.showInformationMessage("Auto-Align only works on selections.");
        return;
      }

      editor.edit((editBuilder) => {
        selections.forEach((selection) => {
          let aligned = aligner.align(getTextFromSelection(editor, selection));
          replaceEditBuilderSelectionWith(editBuilder, selection, aligned);
        });
      });
    });

    context.subscriptions.push(disposable);
}
exports.activate = activate;

// this method is called when your extension is deactivated
function deactivate() {
}
exports.deactivate = deactivate;
function getMoveableItemsArray() {
  let config= vscode.workspace.getConfiguration().get('autoalign.moveableItems') || [];
  let additional =vscode.workspace.getConfiguration().get('autoalign.moveableItemsAdditional') || [];
  return config.concat(additional);
}
function getNonMoveableItemsArray() {
  let config= vscode.workspace.getConfiguration().get('autoalign.nonMoveableItems') || [];
  let additional =vscode.workspace.getConfiguration().get('autoalign.nonMoveableItemsAdditional') || [];
  return config.concat(additional);
}
function getSkippableEndingItemsArray() {
  let config= vscode.workspace.getConfiguration().get('autoalign.skipLinesEndingWithItems') || [];
  let additional =vscode.workspace.getConfiguration().get('autoalign.skipLinesEndingWithItemsAdditional') || [];
  return config.concat(additional);
}
function getTextFromSelection(editor, selection) {
  if ( ! editor || ! editor.document || ! selection) {
    return null;
  }
  return editor.document.getText(rangeFromSelection(selection));
}
function replaceEditBuilderSelectionWith(editBuilder, selection, newText) {
  if ( ! editBuilder || ! selection) {
    return;
  }
  editBuilder.replace(rangeFromSelection(selection), newText);
}
function rangeFromSelection(selection, includeFullLine=true) {
  let startChar = includeFullLine ? 0 : selection.start.character;
  let endChar = includeFullLine ? 5000 : selection.end.character;
  return new vscode.Range(selection.start.line, startChar, selection.end.line, endChar);
}
function isSomethingSelected(editor) {
  if ( ! editor) {
    return false;
  }
  let selections        = editor.selections; // handle multiple selections the same
  let foundSomething    = false;
  selections.forEach(selection => {
    if (selection.start.line !== selection.end.line) {
      foundSomething    = true;
    }
  });

  return foundSomething;
}
/** 
 * - - - - - - - - - - - - - -
 * ALIGNER
 * - - - - - - - - - - - - - -
 * Main action class
 */
class Aligner {
  constructor() {
    this.movableItemsList       = [];
    this.nonMovableItemsList    = [];
    this.skippableEndingItemsArray = [];
    this.minSeparationLeft      = 3;
    this.minSeparationRight     = 1;
    this.columnWidth            = undefined;
  }
  align(text) {
    if (!text) {
      return text;
    }

    const lines                     = text.split(/\r\n|\r|\n/);

    // NOT ENOUGH TO COMPARE
    if (lines.length < 2) {
      return text;
    }

    // GET FARTHEST ALIGNABLE ELEMENT
    let farthestAlignablePosition   = 0;
    lines.forEach(line => {
      let alignable                 = this._getAlignablePositionAndItem(line);

      let leftStringTrimed          = line.substr(0, alignable.position).trimRight();
      let lineAlignPosition         = leftStringTrimed.length;

      if (lineAlignPosition >= farthestAlignablePosition) {

        // this is the farthest we've been!
        farthestAlignablePosition   = lineAlignPosition;
        
        // now, figure out how much white-space is "to the left" of the character
        let leftOfCharacter         = line.substr(0, lineAlignPosition-1);
        let unTrimmedLength         = leftOfCharacter.length;
        let trimmendLength          = this._trimEnd(leftOfCharacter).length;
        let whiteAtEndCount         = (unTrimmedLength - trimmendLength);

        // we need to make sure it is the "minimumLeft" white-space
        if (whiteAtEndCount < this.minSeparationLeft) {
          let addAtEndCount   = this.minSeparationLeft - whiteAtEndCount;
          farthestAlignablePosition         += addAtEndCount;          
        }

        // NEAREST FACTOR OF
        if (this.columnWidth > 1 && farthestAlignablePosition % this.columnWidth) { 
          let numberOfWholeColumns      = ~~(farthestAlignablePosition / this.columnWidth);
          farthestAlignablePosition     = (numberOfWholeColumns + 1) * this.columnWidth;
        }
      }
    });

    // WE HAVE THINGS TO ALIGN
    if (farthestAlignablePosition > 0) {
      for (let i = 0; i < lines.length; i++) {
        lines[i]                    = this._alignToPosition(lines[i], farthestAlignablePosition);
      }
    }
    
    return lines.join('\n');
  }

  //** INTERNALS */
  _alignToPosition(line, position) {
    let moveable = this._getAlignablePositionAndItem(line);

    // BAIL : nothing is movable
    if (moveable.position < 0 || moveable.position >= line.length) {
      return line;
    }

    // create parts
    let leftLine            = line.substr(0, moveable.position).trimRight();
    let rightLine           = line.substr(moveable.position + moveable.item.length).trim();
    let leftInsertString    = ' '.repeat(position - leftLine.length);
    let rightInsertString   = ' '.repeat(Math.max(this.minSeparationRight, 1));

    return leftLine + leftInsertString + moveable.item + rightInsertString + rightLine;
  }
  _getAlignablePositionAndItem(line) {
    let reply = {
      position    : -1,
      item        : undefined
    }
    
    let moveable        = this._getNearestMovablePositionAndItem(line);

    // BAIL : nothing is movable
    if (moveable.position < 0) {
      return reply;
    }

    let nonMoveable     = this._getNearestNonMovablePositionAndItem(line);

    // WE HAVE NON-MOVABLES FIRST : nothing is movable
    if (nonMoveable.position > -1 && nonMoveable.position <= moveable.position ) {
      return reply;
    }

    reply.position      = moveable.position;
    reply.item          = moveable.item;

    return reply;
  }
  _getNearestMovablePositionAndItem(line) {
    return this._getNearestOccurancePositionAndItem(line, this.movableItemsList);
  }
  _getNearestNonMovablePositionAndItem(line) {
    return this._getNearestOccurancePositionAndItem(line, this.nonMovableItemsList);
  }
  _getNearestOccurancePositionAndItem(line, itemList) {
    /**
     * will return a structure so that a caller can tell
     * where the item is in the line but also what was found
     *   {
     *    position : 5,
     *    item : '=='
     *   } 
     * 
     */
    let reply = {
      position    : -1,
      item        : undefined
    }

    // SKIPPABLE
    if (this._isLineSkippable(line)) {
      return reply;
    }

    let nearestPosition                   = 1000000; // simply huge to start
    let foundItem                         = undefined;
    for (let i = 0; i < itemList.length; i++) {
      const item                          = itemList[i];
      let positionOfItem                  = line.indexOf(item);
      if (positionOfItem > -1) {
        foundItem                         = item;
        nearestPosition                   = Math.min(nearestPosition, line.indexOf(item));
      }
    }

    if (foundItem) {
      reply.position    = nearestPosition;
      reply.item        = foundItem;
    }
    return reply;
  }
  _isLineSkippable(line) {
    if ( ! line || line.length < 1 ) {
      return true;
    }

    let trimmedLine = this._trimEnd(line);
    for (let i = 0; i < this.skippableEndingItemsArray.length; i++) {
      const item = this.skippableEndingItemsArray[i];
      if (this._endsWith(trimmedLine, item)) {
        return true;
      }      
    }

    return false;
  }
  _splice(text, start, delCount, insertText) {
    return text.slice(0, start) + insertText + text.slice(start + Math.abs(delCount));
  }
  _trimEnd(text) {
    if ( !text || text.length < 1) {
      return text;
    }
    return text.replace(/[\s\uFEFF\xA0]+$/g, '');
  }
  _regexLastIndexOf(text, regex, startpos) {
    // alteration of answer : https://stackoverflow.com/a/274094/473501
    if ( ! text || ! regex) {
      return -1;
    }

    regex                   = (regex.global) ? regex : new RegExp(regex.source, "g" + (regex.ignoreCase ? "i" : "") + (regex.multiLine ? "m" : ""));
    if (typeof(startpos) === "undefined") {
        startpos            = text.length;
    } 
    
    else if(startpos < 0) {
        startpos            = 0;
    }

    let stringToWorkWith    = text.substring(0, startpos + 1);
    let lastIndexOf         = -1;
    let nextStop            = 0;
    let result;

    while((result           = regex.exec(stringToWorkWith)) != null) {
        lastIndexOf         = result.index;
        regex.lastIndex     = ++nextStop;
    }
    return lastIndexOf;
  }
  _endsWith(text, lookFor, caseInsensitive) {
    if ( ! text || text.length < 1 || ! lookFor || lookFor.length < 1 ) {
      return false;
    }
  
    if (caseInsensitive) {
      return text.toLowerCase().slice(-lookFor.length) === lookFor.toLowerCase();
    }
  
    return text.slice(-lookFor.length) === lookFor;
  }
}