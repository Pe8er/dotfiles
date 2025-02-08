#!/bin/bash

transmission=(
  label.padding_right=4
  icon.drawing=off
  update_freq=5
  script="$PLUGIN_DIR/transmission.sh"
  click_script="open -a /Applications/Transmission.app"
)

sketchybar --add item transmission right       \
           --set      transmission "${transmission[@]}"