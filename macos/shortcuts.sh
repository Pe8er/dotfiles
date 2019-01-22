#!/bin/bash

defaults write -g NSUserKeyEquivalents '{
"Show Previous Tab" = "@$Z";
"Show Next Tab" = "@$X";
"Select Previous Tab" = "@$Z";
"Select Next Tab" = "@$X";
"Select Previous Conversation" = "@$Z";
"Select Next Conversation" = "@$X";
"Select Previous Tab" = "@$Z";
"Select Next Tab" = "@$X";
"Guide Lines" = "@'\''";
"Show Guides" = "@'\''";
"Hide Guides" = "@'\''";
"Copy Animation" = "@^C";
"Paste Animation" = "@^V";
"Increase Quote Level" = "@]";
"Decrease Quote Level" = "@[";
}'

defaults write com.tsst.simplecomic NSUserKeyEquivalents '{
  "Full Screen" = "f";
}'

defaults write com.bohemiancoding.sketch3 NSUserKeyEquivalents '{
  "Round to Pixel" = "@\\";
}'

defaults write -app Safari NSUserKeyEquivalents '{
"Reopen Last Closed Window" = "@~r";
"Reopen Last Closed Tab" = "@z";
"Move Tab to New Window" = "@~n";
"Merge All Windows" = "@$m";
"Minimize All" = "@~,";
}'

defaults write com.apple.mail NSUserKeyEquivalents '{
"Clear Flag" = "@$L";
"Insert Bulleted List" = "@$U";
"Insert Numbered List" = "@$O";
"Archive" = "\U007F";
"Send" = "@\U000D";
"Reply" = "r";
}'

defaults write com.apple.finder NSUserKeyEquivalents '{
"Show Package Contents" = "^r";
}'

echo "Shortcuts added successfuly!"

comment="
Reference: http://www.hcs.harvard.edu/~jrus/site/cocoa-text.html

@ = Command
^ = Control
~ = Option
$ = Shift
@^$T = Command-Control-Shift-T
~  = Option-space
~\\$ = Option-$ -- escape!

Escape: \U001B
Tab:  \U0009
Backtab:  \U0019
Return: \U000A
Enter:  \U000D
Delete: \U007F
Up Arrow: \UF700
Down Arrow: \UF701
Left Arrow: \UF702
Right Arrow:  \UF703
Help: \UF746
Forward Delete: \UF728
Home: \UF729
End:  \UF72B
Page Up:  \UF72C
Page Down:  \UF72D
Clear:  \UF739
F1: \UF704
F2: \UF705
F3: \UF706
…
F35 \UF726
"
