#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

DRAWING="on"

COUNT=$(brew outdated | wc -l | tr -d ' ')

case "$COUNT" in
[3-5][0-9])
  COLOR=$(getcolor red)
  ;;
[1-2][0-9])
  COLOR=$(getcolor orange)
  ;;
[1-9])
  COLOR=$(getcolor yellow)
  ;;
0|"")
  COLOR=$LABEL_COLOR
  DRAWING="off"
  ;;
esac

sketchybar --animate tanh 20 --set $NAME label.drawing=$DRAWING label=$COUNT icon.color=$COLOR