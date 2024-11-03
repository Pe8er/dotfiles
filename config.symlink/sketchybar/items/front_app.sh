#!/bin/sh

front_app=(
  icon.color=$(getcolor white 50)
  label.padding_right=0
  script="$PLUGIN_DIR/front_app.sh"
)

sketchybar                             \
--add item front_app left              \
     --set front_app "${front_app[@]}" \
     --subscribe front_app_switched space_change space_windows_change