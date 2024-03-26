#!/bin/env/bash

battery=(
  icon.font.size=16
  icon.padding_right=0
  icon.font.style="Light"
  update_freq=60                                             
  popup.align=right                                            
  script="$PLUGIN_DIR/battery.sh"                              
  updates=when_shown                                           
)

sketchybar                                 \
  --add item battery right                 \
  --set battery "${battery[@]}"            \
  --subscribe battery power_source_change  \
                      mouse.clicked