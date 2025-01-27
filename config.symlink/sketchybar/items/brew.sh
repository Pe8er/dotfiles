#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

brew=(
  "${notification_defaults[@]}"
  icon=$ICON_PACKAGE
  script="$PLUGIN_DIR/brew.sh"
  click_script="$PLUGIN_DIR/brew.sh"
  --subscribe brew mouse.clicked
)

sketchybar --add item  brew right            \
           --set       brew "${brew[@]}"