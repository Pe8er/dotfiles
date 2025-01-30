#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

update_label() {
  if [ "$(cat /tmp/sketchybar_sender)" = "focus_off" ]; then
    DRAWING="on"
  fi
  COUNT=$(brew outdated | wc -l | tr -d ' ')

  case "$COUNT" in
  [7-9] | [1-9][0-9])
    COLOR=$(getcolor red)
    ;;
  [3-6])
    COLOR=$(getcolor orange)
    ;;
  [1-2])
    COLOR=$(getcolor yellow)
    ;;
  0 | "")
    COLOR=$LABEL_COLOR
    DRAWING="off"
    ;;
  esac

  sketchybar --animate tanh 20 --set $NAME drawing=$DRAWING label=$COUNT icon.color=$COLOR
}

mouse_clicked() {
  sketchybar --set $NAME icon=$ICON_REFRESH
  $CONFIG_DIR/items/brew_script.sh &

  # Wait for the brew process to finish
  wait $!
  echo "Brew update and upgrade are complete."
  update_label
  sketchybar --set $NAME icon=$ICON_PACKAGE
}

case "$SENDER" in
"routine" | "forced")
  update_label
  ;;
"mouse.clicked")
  mouse_clicked
  ;;
esac