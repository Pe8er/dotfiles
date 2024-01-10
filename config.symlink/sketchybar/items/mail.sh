#!/bin/env/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

mail=(
  "${notification_defaults[@]}"
  icon=􀣪
  background.color=$YELLOW
  script="$PLUGIN_DIR/mail.sh"
  click_script="open -a /System/Applications/Mail.app"
)

sketchybar --add item mail right       \
           --set      mail "${mail[@]}"