#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

control_center=(
  icon=$ICON_CONTROLCENTER
  label.drawing=off
  icon.padding_left=$PADDINGS
  icon.padding_right=$PADDINGS
  icon.y_offset=1.5
  click_script="osascript -e 'tell application \"System Events\" to tell process \"Control Center\" to perform action \"AXPress\" of menu bar item 2 of menu bar 1' >/dev/null 2>&1"
)

sketchybar --add item control_center right          \
           --set      control_center "${control_center[@]}" \
           --set      control_center "${bracket_defaults[@]}"
