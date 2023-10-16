var vscode = require( 'vscode' ),
    path = require( 'path' );

var startEndField;
var innerField;

var lastVersion;

function getSplitRegex( separator )
{
    // https://stackoverflow.com/questions/23582276/split-string-by-comma-but-ignore-commas-inside-quotes
    return new RegExp( '\\' + separator + '(?=(?:(?:[^"]*"){2})*[^"]*$)', 'g' );
}

function activate( context )
{
    var button = vscode.window.createStatusBarItem( vscode.StatusBarAlignment.Left, 0 );

    var formatTimeout;

    String.prototype.rtrim = function() { return this.replace( /\s+$/, '' ); }
    String.prototype.trim = function() { return this.replace( /^\s+|\s+$/g, '' ); }

    function getExtension()
    {
        var editor = vscode.window.activeTextEditor;
        if( editor && editor.document )
        {
            ext = path.extname( editor.document.fileName );
            if( ext && ext.length > 1 )
            {
                return ext.substr( 1 );
            }
        }
        return "";
    }

    function associatedFileSeparator()
    {
        var associations = vscode.workspace.getConfiguration( 'autoAlign' ).get( 'associations' );
        return associations ? associations[ getExtension() ] : undefined;
    }

    function updateSeparator()
    {
        var separator = associatedFileSeparator();
        if( separator )
        {
            startEndField = new RegExp( "(^.*?\\" + separator + "|\\" + separator + ".*? $)" );
            innerField = new RegExp( "\\" + separator + ".*?\\" + separator );
        }
    }

    function appendColumn( lines, linesParts, max )
    {
        for( var linePartIndex = 0; linePartIndex < linesParts.length; linePartIndex++ )
        {
            var alignment = vscode.workspace.getConfiguration( 'autoAlign' ).get( 'alignment' );

            var part = alignment === "left" ? padRight( linesParts[ linePartIndex ].shift(), max ) : padLeft( linesParts[ linePartIndex ].shift(), max );

            if( lines[ linePartIndex ] === undefined ) lines[ linePartIndex ] = '';
            lines[ linePartIndex ] += part;
        }
    }

    function appendDelimiter( lines, delimiter )
    {
        for( var linePartIndex = 0; linePartIndex < lines.length; linePartIndex++ )
        {
            lines[ linePartIndex ] = lines[ linePartIndex ] + delimiter;
        }
    }

    function padRight( text, count )
    {
        if( count > 0 )
        {
            var padAmount = text ? ( count - text.length ) : count;
            return ( text ? text : "" ) + ' '.repeat( padAmount );
        }
        else if( count < 0 )
        {
            return text ? text.trim() : "";
        }
        return text ? text : "";
    }

    function padLeft( text, count )
    {
        if( count > 0 )
        {
            var padAmount = text ? ( count - text.length ) : count;
            return ' '.repeat( padAmount ) + ( text ? text : "" );
        }
        else if( count < 0 )
        {
            return text ? text.trim() : "";
        }
        return text ? text : "";
    }

    function maxLength( texts, partIndex )
    {
        return texts.map( text => ( text[ partIndex ] ? text[ partIndex ].rtrim().length : 0 ) ).reduce( ( prev, curr ) =>
        {
            return curr >= prev ? curr : prev;
        } );
    }

    function replaceLinesWithText( textEditor, linesOld, linesNew )
    {
        function copySelection( source )
        {
            var target = new vscode.Selection( source.anchor, source.active );
            target.end = new vscode.Position( source.end );
            target.isEmpty = source.isEmpty;
            target.isReversed = source.isReversed;
            target.isSingleLine = source.isSingleLine;
            target.start = new vscode.Position( source.start );
            return target;
        }

        var previousSelection = copySelection( textEditor.selection );
        var previousSelections = [];
        textEditor.selections.forEach( s => { previousSelections.push( copySelection( s ) ); } );

        textEditor.edit( function( editBuilder )
        {
            var lineIndex = 0;
            linesOld.forEach( line =>
            {
                editBuilder.replace( line.range, linesNew[ lineIndex ] );
                lineIndex++;
            } );
        }, { undoStopAfter: false, undoStopBefore: false } ).then(
            function()
            {
                textEditor.selection = previousSelection;
                textEditor.selections = previousSelections;
            }
        );
    }

    function alignCSV( textEditor, selection, expand, overriddenSeparator )
    {
        if( expand === undefined )
        {
            expand = true;
        }

        var separator = overriddenSeparator ? overriddenSeparator : associatedFileSeparator();
        var document = textEditor.document;
        var text = document.getText();
        var firstLine = document.positionAt( text.indexOf( separator ) );
        var lastLine = document.positionAt( text.lastIndexOf( separator ) );

        if( selection )
        {
            firstLine = selection.start;
            lastLine = selection.end;
            if( selection.end.character === 0 )
            {
                lastLine = new vscode.Position( lastLine.line - 1 );
            }
        }

        var lines = [];
        for( var index = firstLine.line; index <= lastLine.line; index++ )
        {
            lines.push( document.lineAt( index ) );
        }

        var splitRegex = getSplitRegex( separator );
        // var splitRegex = new RegExp( '(?<=")[^"]+?(?="(?:\s*?,|\s*?$))|(?<=(?:^|,)\s*?)(?:[^,"\s][^,"]*[^,"\s])|(?:[^,"\s])(?![^"]*?"(?:\s*?,|\s*?$))(?=\s*?(?:,|$))');
        var linesParts = lines.map( line => line.text.split( splitRegex ) );
        if( expand === true )
        {
            var extraSpace = vscode.workspace.getConfiguration( 'autoAlign' ).get( 'extraSpace' ) === true ? " " : "";
            linesParts = linesParts.map( function( line )
            {
                return line.map( function( part, index )
                {
                    return ( index === 0 ? "" : extraSpace ) + part.trim();
                } );
            } );
        }
        var linePartCount = 0;
        linesParts.map( function( line )
        {
            if( line.length > linePartCount )
            {
                linePartCount = line.length;
            }
        } );

        var newLineTexts = [];
        var columnWidths = Array( linePartCount ).fill( -1 );
        if( expand )
        {
            for( var columnIndex = linePartCount - 1; columnIndex >= 0; columnIndex-- )
            {
                columnWidths[ columnIndex ] = maxLength( linesParts, columnIndex );
                if( columnWidths[ columnIndex ] === 0 && columnIndex === linePartCount - 1 )
                {
                    linePartCount--;
                }
            }
        }
        for( var columnIndex = 0; columnIndex < linePartCount; columnIndex++ )
        {
            var addEndingSeparator = vscode.workspace.getConfiguration( 'autoAlign' ).get( 'endingSeparator', false );
            var lastColumn = addEndingSeparator === true ? linePartCount : linePartCount - 1;
            var max = columnIndex < lastColumn ? columnWidths[ columnIndex ] : ( expand ? 0 : -1 );
            if( columnIndex > 0 )
            {
                appendDelimiter( newLineTexts, separator );
            }
            appendColumn( newLineTexts, linesParts, max );
            if( ( columnIndex === linePartCount - 1 ) && addEndingSeparator === true )
            {
                appendDelimiter( newLineTexts, separator );
            }
        }

        return { oldLines: lines, newLines: newLineTexts };
    }

    var decorationType = vscode.window.createTextEditorDecorationType( {
        light: { color: "#cccccc" },
        dark: { color: "#444444" }
    } );

    function decorate()
    {
        var editor = vscode.window.activeTextEditor;

        var highlights = [];

        if( vscode.workspace.getConfiguration( 'autoAlign' ).get( 'dimSeparators' ) === true )
        {
            var separator = associatedFileSeparator();

            if( vscode.workspace.getConfiguration( 'autoAlign' ).get( 'enabled' )[ getExtension() ] )
            {
                var text = editor.document.getText();
                var pattern = getSplitRegex( separator );

                var match;
                while( match = pattern.exec( text ) )
                {
                    var startPos = editor.document.positionAt( match.index );
                    var endPos = editor.document.positionAt( match.index + match[ 0 ].length );
                    var decoration = { range: new vscode.Range( startPos, endPos ) };
                    highlights.push( decoration );
                }
            }
        }

        editor.setDecorations( decorationType, highlights );
    }

    function align( expand, selections, overriddenSeparator )
    {
        var editor = vscode.window.activeTextEditor;

        if( editor )
        {
            var aligned;
            if( selections )
            {
                var oldLines = [];
                var newLines = [];
                editor.selections.map( function( selection )
                {
                    aligned = alignCSV( editor, selection, expand, overriddenSeparator );
                    oldLines.push.apply( oldLines, aligned.oldLines );
                    newLines.push.apply( newLines, aligned.newLines );
                } );
                replaceLinesWithText( editor, oldLines, newLines );
            }
            else
            {
                aligned = alignCSV( editor, undefined, expand );
                replaceLinesWithText( editor, aligned.oldLines, aligned.newLines );
            }
        }
    }

    function positionCursor()
    {
        var editor = vscode.window.activeTextEditor;

        if( editor && vscode.workspace.getConfiguration( 'autoAlign' ).get( 'repositionCursor' ) === true )
        {
            var text = editor.document.getText();

            var selection = editor.selection;
            var cursorPos = editor.document.offsetAt( selection.start );
            var currentWordRange = editor.document.getWordRangeAtPosition( selection.active, startEndField );
            if( currentWordRange === undefined )
            {
                currentWordRange = editor.document.getWordRangeAtPosition( selection.active, innerField );
            }
            if( currentWordRange )
            {
                var currentWord = text.substring( editor.document.offsetAt( currentWordRange.start ) + 1, editor.document.offsetAt( currentWordRange.end ) - 1 );
                var currentWordStart = editor.document.offsetAt( currentWordRange.start ) + 1;
                var currentWordEnd = currentWordStart + currentWord.rtrim().length + 1;
                if( cursorPos > currentWordEnd )
                {
                    var position = editor.document.positionAt( currentWordEnd );
                    editor.selection = new vscode.Selection( position, position );
                    editor.revealRange( editor.selection, vscode.TextEditorRevealType.Default );
                }
            }
        }
    }

    function go( e )
    {
        function doFormat()
        {
            if( !e || e.kind === undefined || e.kind == vscode.TextEditorSelectionChangeKind.Keyboard )
            {
                align( vscode.workspace.getConfiguration( 'autoAlign' ).get( 'enabled' )[ getExtension() ] === true );
            }
            positionCursor();
            setTimeout( decorate, 100 );
            formatTimeout = null;
        };

        var editor = vscode.window.activeTextEditor;
        if( editor && editor.document )
        {
            var version = editor.document.version;

            var enabled = vscode.workspace.getConfiguration( 'autoAlign' ).get( 'enabled' )[ getExtension() ];
            vscode.commands.executeCommand( 'setContext', 'auto-align-enabled', enabled );

            if( enabled )
            {
                if( !lastVersion || version > lastVersion )
                {
                    lastVersion = version;
                    clearTimeout( formatTimeout );
                    if( vscode.workspace.getConfiguration( 'autoAlign' ).get( 'enabled' )[ getExtension() ] )
                    {
                        var delay = vscode.workspace.getConfiguration( 'autoAlign' ).get( 'delay' );
                        if( e && ( e.kind && e.kind == vscode.TextEditorSelectionChangeKind.Mouse ) )
                        {
                            delay = 0;
                        }

                        formatTimeout = setTimeout( doFormat, delay );
                    }
                    else
                    {
                        clearTimeout( formatTimeout );
                    }
                }
                else
                {
                    if( formatTimeout )
                    {
                        clearTimeout( formatTimeout );
                        formatTimeout = setTimeout( doFormat, delay );
                    }
                }
            }
            else
            {
                clearTimeout( formatTimeout );
            }
        }
    }

    function setButton( filename )
    {
        var enabled = vscode.workspace.getConfiguration( 'autoAlign' ).get( 'enabled' )[ getExtension() ] === true;

        button.text = "Auto Align: $(thumbs" + ( enabled ? "up" : "down" ) + ")";
        button.command = 'auto-align.' + ( enabled ? 'disable' : 'enable' );
        if( associatedFileSeparator() )
        {
            button.show();
        }
        else
        {
            button.hide();
        }
    }

    function enable()
    {
        vscode.commands.executeCommand( 'setContext', 'auto-align-enabled', true );
        var enabled = vscode.workspace.getConfiguration( 'autoAlign' ).get( 'enabled' );
        enabled[ getExtension() ] = true;
        vscode.workspace.getConfiguration( 'autoAlign' ).update( 'enabled', enabled, true );
    }

    function disable()
    {
        vscode.commands.executeCommand( 'setContext', 'auto-align-enabled', false );
        var enabled = vscode.workspace.getConfiguration( 'autoAlign' ).get( 'enabled' );
        enabled[ getExtension() ] = false;
        vscode.workspace.getConfiguration( 'autoAlign' ).update( 'enabled', enabled, true );
    }

    function changeSeparator()
    {
        var editor = vscode.window.activeTextEditor;
        var prompt = "Enter the separator for ." + getExtension() + " files";
        var oldSeparator = associatedFileSeparator();
        vscode.window.showInputBox( { prompt: prompt + " (current:\"" + oldSeparator + "\"):" } ).then(
            function( newSeparator )
            {
                if( newSeparator )
                {
                    var associations = vscode.workspace.getConfiguration( 'autoAlign' ).get( 'associations' );
                    var updated = function()
                    {
                        separator = newSeparator;
                        setButton();
                        updateSeparator();
                        go( { textEditor: vscode.activeTextEditor } );
                    }
                    if( editor.document )
                    {
                        associations[ getExtension() ] = newSeparator;
                        vscode.workspace.getConfiguration( 'autoAlign' ).update( 'associations', associations, true ).then( updated );
                    }
                }
            } );
    }

    function moveCursorToNextField()
    {
        var editor = vscode.window.activeTextEditor;
        if( editor )
        {
            var text = editor.document.getText();
            var cursorPos = editor.document.offsetAt( editor.selection.start );
            var nextSeparator = text.substr( cursorPos ).indexOf( associatedFileSeparator() );
            if( nextSeparator > -1 )
            {
                nextSeparator += ( vscode.workspace.getConfiguration( 'autoAlign' ).get( 'extraSpace' ) === true ? 2 : 1 );
            }
            var nextLine = text.substr( cursorPos ).indexOf( '\n' );
            if( nextLine > -1 )
            {
                nextLine += 1;
            }
            var nextPosition = [ nextSeparator, nextLine ];
            nextPosition = nextPosition.filter( p => { return p > -1; } ).sort( ( a, b ) => a - b );

            if( nextPosition.length > 0 )
            {
                var newPosition = editor.document.positionAt( cursorPos + nextPosition.shift() );
                var newSelection = new vscode.Selection( newPosition, newPosition );
                editor.selection = newSelection;
            }
        }
    }

    function moveCursorToPreviousField()
    {
        var editor = vscode.window.activeTextEditor;
        if( editor )
        {
            var text = editor.document.getText();
            var cursorPos = editor.document.offsetAt( editor.selection.start ) - 1;
            if( vscode.workspace.getConfiguration( 'autoAlign' ).get( 'extraSpace' ) === true )
            {
                cursorPos -= 1;
            }
            var previousSeparator = text.substr( 0, cursorPos ).lastIndexOf( associatedFileSeparator() );
            if( previousSeparator > -1 )
            {
                previousSeparator += ( vscode.workspace.getConfiguration( 'autoAlign' ).get( 'extraSpace' ) === true ? 2 : 1 );
            }
            var previousLine = text.substr( 0, cursorPos ).lastIndexOf( '\n' );
            if( previousLine > -1 )
            {
                previousLine += 1;
            }
            var previousPosition = [ previousSeparator, previousLine ];
            previousPosition = previousPosition.filter( p => { return p > -1; } ).sort( ( a, b ) => a - b );

            var newPosition = editor.document.positionAt( previousPosition.length > 0 ? previousPosition.pop() : 0 );
            var newSelection = new vscode.Selection( newPosition, newPosition );
            editor.selection = newSelection;
        }
    }

    context.subscriptions.push( vscode.commands.registerCommand( 'auto-align.changeSeparator', changeSeparator ) );
    context.subscriptions.push( vscode.commands.registerCommand( 'auto-align.alignColumns', function() { align( true ); } ) );
    context.subscriptions.push( vscode.commands.registerCommand( 'auto-align.collapseColumns', function() { align( false ); } ) );
    context.subscriptions.push( vscode.commands.registerCommand( 'auto-align.enable', enable ) );
    context.subscriptions.push( vscode.commands.registerCommand( 'auto-align.disable', disable ) );
    context.subscriptions.push( vscode.commands.registerCommand( 'auto-align.moveCursorToNextField', moveCursorToNextField ) );
    context.subscriptions.push( vscode.commands.registerCommand( 'auto-align.moveCursorToPreviousField', moveCursorToPreviousField ) );

    context.subscriptions.push( vscode.commands.registerCommand( 'auto-align.alignSelection', function()
    {
        var editor = vscode.window.activeTextEditor;

        if( editor && editor.document )
        {
            align( true, editor.selections );
        }
    } ) );

    context.subscriptions.push( vscode.commands.registerCommand( 'auto-align.alignSelectionWithSeparator', function()
    {
        var editor = vscode.window.activeTextEditor;

        if( editor && editor.document )
        {
            var prompt = "Enter the required separator";
            var defaultSeparator = associatedFileSeparator();
            if( defaultSeparator )
            {
                prompt += "(default: \"" + defaultSeparator + "\")";
            }
            vscode.window.showInputBox( { prompt: prompt } ).then(
                function( separator )
                {
                    if( separator !== undefined )
                    {
                        align( true, editor.selections, separator );
                    }
                } );
        }
    } ) );

    context.subscriptions.push( vscode.window.onDidChangeTextEditorSelection( go ) );
    context.subscriptions.push( vscode.workspace.onDidChangeConfiguration( function( e )
    {
        if( e.affectsConfiguration( 'autoAlign' ) )
        {
            if( e.affectsConfiguration( 'autoAlign.enabled' ) )
            {
                var enabled = vscode.workspace.getConfiguration( 'autoAlign' ).get( 'enabled' )[ getExtension() ];
                setButton();
                if( enabled )
                {
                    lastVersion = undefined;
                    go();
                }
                else
                {
                    setTimeout( decorate, 100 );
                    if( vscode.workspace.getConfiguration( 'autoAlign' ).get( 'collapseOnDisable' ) === true )
                    {
                        align( false );
                    }
                }
            }
            else
            {
                lastVersion = undefined;
                go();
            }
        }
    } ) );

    context.subscriptions.push( vscode.window.onDidChangeActiveTextEditor( function( e )
    {
        if( e && e.document )
        {
            updateSeparator();
            setButton( e.document.fileName );
            lastVersion = e.document.version - 1;
            go();
        }
    } ) );

    updateSeparator();

    var editor = vscode.window.activeTextEditor;

    if( editor && editor.document )
    {
        vscode.commands.executeCommand( 'setContext', 'auto-align-enabled', vscode.workspace.getConfiguration( 'autoAlign' ).get( 'enabled' )[ getExtension() ] );
        setButton( editor.document.fileName );
        go( {} );
    }
}

exports.activate = activate;

function deactivate()
{
}
exports.deactivate = deactivate;
