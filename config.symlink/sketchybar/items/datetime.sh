#!/bin/env/bash

date=(
  icon.drawing=off                   
  label.font="$FONT:Semibold:8"      
  label.padding_right=4                   
  y_offset=5                         
  width=0                            
  update_freq=60                     
  script='sketchybar --set $NAME label="$(date "+%a, %b %d")"'
  click_script="open -a Calendar.app"
)

clock=(
  "${menu_defaults[@]}"
  icon.drawing=off          
  label.font="$FONT:Bold:10" 
  label.padding_right=4           
  y_offset=-3            
  update_freq=10            
  popup.align=right         
  script="$PLUGIN_DIR/nextevent.sh"
  click_script="sketchybar --set clock popup.drawing=toggle; open -a Calendar.app"
)

sketchybar                                      \
  --add item date right                         \
  --set date "${date[@]}"                       \
  --subscribe date system_woke                  \
                   mouse.entered                \
                   mouse.exited                 \
                   mouse.exited.global          \
  --add item date.details popup.date            \
  --set date.details "${menu_item_defaults[@]}" \
                                                \
  --add item clock right                        \
  --set clock "${clock[@]}"                     \
  --subscribe clock system_woke                 \
                    mouse.entered               \
                    mouse.exited                \
                    mouse.exited.global         \
  --add item clock.details popup.clock          \
  --set clock.details "${menu_item_defaults[@]}" icon.drawing=off label.padding_left=0