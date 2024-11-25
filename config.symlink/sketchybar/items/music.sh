#!/bin/env/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

music=(
  background.border_color="$(getcolor grey 50)"
  background.border_width=1
  background.color=$TRANSPARENT
  background.image.corner_radius=4
  background.image.scale=0.6
  icon.padding_right=24
  label.max_chars=24
  label.padding_right=$PADDINGS
  label.scroll_duration=100
  padding_right=$PADDINGS
  script="$PLUGIN_DIR/music.sh"
  click_script="$PLUGIN_DIR/music.sh"
  updates=on
  --subscribe music media_change mouse.clicked
)

sketchybar \
  --add item music right \
  --set music "${music[@]}"
