#!/bin/env/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

music=(
  # popup.align=center
  label.padding_right=$PADDINGS
  drawing=off
  label="Loading…"
  background.color=$TRANSPARENT
  background.image=media.artwork
  background.image.scale=0.6
  background.image.corner_radius=4
  icon.padding_left=16
  label.max_chars=16
  label.scroll_duration=100
  updates=on
  script="$PLUGIN_DIR/music.sh"
  click_script="osascript -e 'tell application \"Spotify\" to playpause'"
  --subscribe music media_change
)

sketchybar                       \
  --add item music right         \
  --set      music "${music[@]}"