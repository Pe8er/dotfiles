#!/usr/bin/env bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

DRAWING=$([ "$(cat /tmp/sketchybar_sender)" == "focus_on" ] && echo "off" || echo "on")

COUNT=$(lsappinfo info -only StatusLabel "Mail" | grep -o '"label"="[0-9]*"' | awk -F'"' '{print $4}')

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