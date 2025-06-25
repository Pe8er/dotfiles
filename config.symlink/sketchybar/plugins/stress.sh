#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

python=$(which python3.11)
totalStress=$($python $HOME/.config/sketchybar/plugins/stress.py)
currentStress=$(echo $totalStress | cut -d'/' -f1)

DRAWING=$([ "$(cat /tmp/sketchybar_sender)" == "focus_on" ] && echo "off" || echo "on")

case "$currentStress" in
[0-9] | [1-2][0-9])
  backgroundColor=$(getcolor teal)
  ;;
[3-4][0-9])
  backgroundColor=$(getcolor yellow)
  ;;
[5-6][0-9])
  backgroundColor=$(getcolor orange)
  ;;
[7-9][0-9])
  backgroundColor=$(getcolor red)
  ;;
*)
  backgroundColor=$LABEL_COLOR
  DRAWING="off"
  ;;
esac

sketchybar --animate tanh 20 --set $NAME drawing=$DRAWING label="$totalStress" background.color=$backgroundColor
