#!/bin/bash

yabai=(
  icon=$ICON_YABAI_GRID
  icon.padding_left=$PADDINGS
  icon.padding_right=$((PADDINGS + 2))
  label.padding_right=$PADDINGS
  script="$PLUGIN_DIR/yabai.sh"
)

# Allows my shortcut / workflow in Alfred to trigger things in Sketchybar
sketchybar --add event alfred_trigger
sketchybar --add event update_yabai_icon

sketchybar --add item yabai left                   \
           --set yabai "${yabai[@]}"               \
           --set yabai "${bracket_defaults[@]}"    \
           --subscribe yabai space_change          \
                             mouse.scrolled.global \
                             mouse.clicked         \
                             front_app_switched    \
                             space_windows_change  \
                             alfred_trigger        \
                             update_yabai_icon