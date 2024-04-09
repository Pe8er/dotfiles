#!/bin/env/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

transmission=(
  "${notification_defaults[@]}"
  icon.drawing=off
  update_freq=5
  background.color=$(getcolor red)
  label.font="JetBrainsMono Nerd Font:Bold:11"
  script="$PLUGIN_DIR/transmission.sh"
  click_script="open -a /Applications/Transmission.app"
)

sketchybar --add item transmission right       \
           --set      transmission "${transmission[@]}"