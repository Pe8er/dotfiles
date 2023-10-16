#!/bin/bash

volume_slider=(
  script="$PLUGIN_DIR/volume.sh"
  updates=on
  label.drawing=off
  icon.drawing=off
  slider.highlight_color=$HIGHLIGHT
  slider.background.height=12
  slider.background.corner_radius=12
  slider.background.color=$GREY
  slider.knob=􀀁
  slider.knob.drawing=off
  padding_right=0
)

volume_icon=(
  click_script="$PLUGIN_DIR/volume_click.sh"
  icon=$VOLUME_100
  icon.width=0
  icon.align=left
  icon.color=$ICON_COLOR
  icon.font="$FONT:Regular:14.0"
  padding_right=0
  label.align=left
  label.width=32
  label.font="$FONT:Regular:14.0"
  label.color=$ICON_COLOR
)

sketchybar --add slider volume right            \
           --set volume "${volume_slider[@]}"   \
           --subscribe volume volume_change     \
                              mouse.clicked     \
                                                \
           --add item volume_icon right         \
           --set volume_icon "${volume_icon[@]}"
