#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

# NEWMESSAGES=$(sqlite3 ~/Library/Messages/chat.db "SELECT text FROM message WHERE is_read=0 AND is_from_me=0 AND text!='' AND date_read=0" | wc -l | awk '{$1=$1};1')
COUNT=$(sqlite3 ~/Library/Messages/chat.db "SELECT COUNT(guid) FROM message WHERE NOT(is_read) AND NOT(is_from_me) AND NOT text =''")

DRAWING="on"

case "$COUNT" in
[7-9]|[1-9][0-9])
  COLOR=$(getcolor red)
  ;;
[3-6])
  COLOR=$(getcolor orange)
  ;;
[1-2])
  COLOR=$(getcolor yellow)
  ;;
0|"")
  COLOR=$LABEL_COLOR
  DRAWING="off"
  ;;
esac

sketchybar --animate tanh 20 --set $NAME label.drawing=$DRAWING label=$COUNT icon.color=$COLOR