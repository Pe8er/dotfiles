#!/bin/bash

yabai=(
  icon=$YABAI_GRID
  label.drawing=off
  script="$PLUGIN_DIR/yabai.sh"
  icon.font="$FONT:Bold:12.0"
)

sketchybar --add event window_focus            \
           --add event windows_on_spaces       \
           --add item yabai left               \
           --set yabai "${yabai[@]}"           \
           --subscribe yabai window_focus      \
                             space_change      \
                             windows_on_spaces \
                             mouse.scrolled.global \
                             mouse.clicked