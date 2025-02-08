#!/bin/bash

brew=(
  "${notification_defaults[@]}"
  icon=$ICON_PACKAGE
  script="$PLUGIN_DIR/brew.sh"
  click_script="$PLUGIN_DIR/brew.sh"
  --subscribe brew mouse.clicked
)

sketchybar --add item  brew $1          \
           --set       brew "${brew[@]}"