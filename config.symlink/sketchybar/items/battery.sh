#!/bin/env/bash

battery=(
  "${menu_defaults[@]}"
  icon.font.size=16
  icon.padding_right=0
  icon.font.style="Light"
  # label.drawing=off
  update_freq=60                                             
  popup.align=right                                            
  click_script="sketchybar --set battery popup.drawing=toggle" 
  script="$PLUGIN_DIR/battery.sh"                              
  updates=when_shown                                           
)

sketchybar                                 \
  --add item battery right                 \
  --set battery "${battery[@]}"            \
  --subscribe battery power_source_change  \
                      mouse.entered        \
                      mouse.exited         \
                      mouse.exited.global  \
                      mouse.clicked \
  --add item battery.details popup.battery \
  --set battery.details "${menu_item_defaults[@]}" icon.drawing=off label.padding_left=0