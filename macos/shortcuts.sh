#!/bin/bash

defaults write -g NSUserKeyEquivalents '{
"Show Previous Tab" = "@$Z";
"Show Next Tab" = "@$X";
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

defaults write -app Sketch NSUserKeyEquivalents '{
  "Round to Pixel" = "@\\";
}'

defaults write -app Safari NSUserKeyEquivalents '{
"Reopen Last Closed Window" = "@~r";
"Reopen Last Closed Tab" = "@z";
"Move Tab to New Window" = "@~n";
"Merge All Windows" = "@$m";
"Minimize All" = "@~,";
}'

defaults write -app Mail NSUserKeyEquivalents '{
"Clear Flag" = "@$L";
"Insert Bulleted List" = "@$U";
"Insert Numbered List" = "@$O";
"Archive" = "@\\";
"Need Reply" = "^R";
"Follow Up" = "^F";
"Stash" = "^S";
"Leads" = "^L";
"Send" = "@\U000D";
"Reply" = "r";
}'

defaults write com.apple.finder NSUserKeyEquivalents '{
"Show Package Contents" = "^r";
}'

defaults write -app OmniGraffle NSUserKeyEquivalents '{
"Fit in Window" = "@0";
}'

defaults write com.guidedways.TodoMac NSUserKeyEquivalents '{
  // Start Date
  // "Remove Start Date" = "~=";
  // "Add a Day" = "=";
  // "Add a Week" = "$=";
  // "Subtract a Day" = "-";
  // "Subtract a Week" = "$-";

  // Navigation
  "Inbox" = "@1";
  "Today" = "@2";
  "All" = "@3";
  "Scheduled" = "@4";
  "Starred" = "@5";
  "Done" = "@6";
  "2Do" = "@0";

  // Task Actions
  // "New Task" = "\U000D"; // macOs blocks it.
  // "As Completed" = "\U0020"; // macOs blocks it.
  "Edit Note" = "@\U0027";
  "Open Links" = "v";
  "Edit Tags" = "/";
  "Edit Recurrence" = "@r";
  "Edit List" = "f";
  // "Delete" = "\U007F"; // macOs blocks it.
  "Start Today" = "t";
  "Due Today" = "$t";
  "Move Up" = "w";
  "Move Down" = "s";
  "Star" = "^s";

  // Other
  "List Jump Bar…" = "g";

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