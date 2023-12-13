#!/bin/env/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

moode=(
  "${bracket_defaults[@]}"
  script="$PLUGIN_DIR/moode.sh"
  padding_right=$PADDINGS
  icon=􀊆
  drawing=off
  label="Loading…"
  label.max_chars=33
  updates=on
  update_freq=10
  --subscribe moode mouse.clicked
)

sketchybar                        \
  --add item moode right          \
  --set      moode "${moode[@]}"