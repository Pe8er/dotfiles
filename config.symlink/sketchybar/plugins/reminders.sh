#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

COUNT=$(( $(reminders show-all --due-date today | grep -E "^[a-zA-Z &]+: \d{1,2}: " | wc -l) + 0 ))

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