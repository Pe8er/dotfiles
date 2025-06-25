#!/bin/bash

stress=(
  "${notification_defaults[@]}"
  background.color=$HIGHLIGHT
  icon.color=$BAR_COLOR
  icon.padding_left=$PADDINGS
  icon=$ICON_STRESS
  label.color=$BAR_COLOR
  label.padding_right=$PADDINGS
  label="Loading…"
  script="$PLUGIN_DIR/stress.sh"
  update_freq=1800
  # updates=when_shown
)

sketchybar --add item  stress $1               \
           --set       stress "${stress[@]}"