#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

if [ "$(cat /tmp/sketchybar_sender)" = "focus_off" ]; then
  DRAWING="on"
fi

COUNT=$(( $(reminders show-all --due-date today | grep -E "^[a-zA-Z &]+: \d{1,2}: " | wc -l) + 0 ))

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

sketchybar --animate tanh 20 --set $NAME drawing=$DRAWING label=$COUNT icon.color=$COLOR