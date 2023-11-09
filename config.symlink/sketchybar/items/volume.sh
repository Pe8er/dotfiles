#!/bin/bash

volume_slider=(
  script="$PLUGIN_DIR/volume.sh"
  updates=on
  label.drawing=off
  icon.drawing=off
  slider.highlight_color=$HIGHLIGHT
  slider.background.height=8
  slider.background.corner_radius=12
  slider.background.color=$WHITE_25
  background.padding_right=-$PADDINGS
)

volume_icon=(
  click_script="$PLUGIN_DIR/volume_click.sh"
  icon=$VOLUME_100
  icon.width=32
  icon.color=$ICON_COLOR
  icon.font="$FONT:Regular:14.0"
  label.drawing=off
)

sketchybar --add slider volume right            \
           --set volume "${volume_slider[@]}"   \
           --subscribe volume volume_change     \
                              mouse.clicked     \
                                                \
           --add item volume_icon right         \
           --set volume_icon "${volume_icon[@]}"
