#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

OUTDATED=$(brew outdated)
COUNT=$(echo $OUTDATED | wc -w | tr -d ' ')

update_label() {
  DRAWING=$([ "$(cat /tmp/sketchybar_sender)" == "focus_on" ] && echo "off" || echo "on")

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
  $(which terminal-notifier) -title "$NAME" -subtitle "$COUNT outdated packages" -message "$(echo -e "$OUTDATED")"
  $CONFIG_DIR/items/brew_script.sh &

  # Wait for the brew process to finish
  wait $!
  echo "Brew update and upgrade are complete."
  sleep 3
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
