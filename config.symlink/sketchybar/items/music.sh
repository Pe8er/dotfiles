#!/bin/env/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

music=(
  drawing=off
  updates=on
  background.border_color="$(getcolor grey 50)"
  background.border_width=1
  background.color=$TRANSPARENT
  background.image.corner_radius=4
  icon.padding_right=24
  background.image.scale=0.6
  label.max_chars=24
  label.padding_right=$PADDINGS
  padding_right=$PADDINGS
  label.scroll_duration=100
  script="$PLUGIN_DIR/music.sh"
  click_script="osascript -e 'tell application \"Spotify\" to playpause'"
  --subscribe music media_change
)

sketchybar                       \
  --add item music right         \
  --set      music "${music[@]}"