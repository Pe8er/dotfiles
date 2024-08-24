#!/bin/env/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

transmission=(
  "${notification_defaults[@]}"
  icon.drawing=off
  update_freq=5
  background.color=$(getcolor blue)
  label.font="JetBrainsMono Nerd Font:Bold:11"
  script="$PLUGIN_DIR/transmission.sh"
  click_script="open -a /Applications/Transmission.app"
  background.corner_radius=4
)

sketchybar --add item transmission right       \
           --set      transmission "${transmission[@]}"