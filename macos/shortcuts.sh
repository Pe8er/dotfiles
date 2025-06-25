#!/bin/bash

defaults write -g NSUserKeyEquivalents '{
"Guide Lines" = "@'\''";
"Show Guides" = "@'\''";
"Hide Guides" = "@'\''";
"Copy Animation" = "@^C";
"Paste Animation" = "@^V";
"Increase Quote Level" = "@]";
"Decrease Quote Level" = "@[";
"Insert Bulleted List" = "@$U";
"Insert Numbered List" = "@$O";
"Bulleted List" = "@$U";
"Numbered List" = "@$O";
"Archive" = "@\\";
}'

defaults write com.tsst.simplecomic NSUserKeyEquivalents '{
  "Full Screen" = "f";
}'

defaults write com.apple.safari NSUserKeyEquivalents '{
"Reopen Last Closed Window" = "@~r";
"Reopen Last Closed Tab" = "@z";
"Move Tab to New Window" = "@~n";
"Merge All Windows" = "@$m";
"Minimize All" = "@~,";
}'

defaults write com.apple.mail NSUserKeyEquivalents '{
"Clear Flag" = "@$L";
"Archive" = "\U007F";
"Send" = "@\U000D";
"Reply" = "r";
}'

defaults write com.apple.finder NSUserKeyEquivalents '{
"Show Package Contents" = "^r";
}'

defaults write company.thebrowser.Browser NSUserKeyEquivalents '{
"Next Tab" = "@~\UF701";
"Previous Tab" = "@~\UF700";
}'

defaults write com.microsoft.Powerpoint NSUserKeyEquivalents '{
"Align Left" = "~a";
"Align Right" = "~d";
"Align Center" = "~h";
"Align Middle" = "~v";
"Align Top" = "~w";
"Align Bottom" = "~s";
}'

defaults write com.apple.reminders NSUserKeyEquivalents '{
"\033Edit\033Priority\033High" = "^1";
"\033Edit\033Priority\033Medium" = "^2";
"\033Edit\033Priority\033Low" = "^3";
"\033Edit\033Priority\033None" = "^0";
"\033Edit\033Mark Due Date As\033None" = "@0";
"Show Reminder Info" = "@i";
}'

echo "Shortcuts added successfuly!"

comment="

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
