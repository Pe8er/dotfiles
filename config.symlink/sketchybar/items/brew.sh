#!/bin/zsh

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

brew=(
  "${notification_defaults[@]}"
  icon=$ICON_PACKAGE
  script="$PLUGIN_DIR/brew.sh"
  click_script="brew update && brew upgrade"
)

sketchybar --add item  brew right            \
           --set       brew "${brew[@]}"