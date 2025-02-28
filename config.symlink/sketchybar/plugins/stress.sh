#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

python=$(which python3.11)
totalStress=$($python $HOME/.config/sketchybar/plugins/stress.py)
currentStress=$(echo $totalStress | cut -d'/' -f1)

[ "$(cat /tmp/sketchybar_sender)" = "focus_off" ] && DRAWING="on"

case "$currentStress" in
"")
  COLOR=$LABEL_COLOR
  DRAWING="off"
  ;;
[7-9][0-9])
  COLOR=$(getcolor red)
  ;;
[5-6][0-9])
  COLOR=$(getcolor orange)
  ;;
[3-4][0-9])
  COLOR=$(getcolor yellow)
  ;;
[0-2][0-9])
  COLOR=$(getcolor green)
  ;;
esac

sketchybar --animate tanh 20 --set $NAME drawing=$DRAWING label="$totalStress" background.color=$COLOR
