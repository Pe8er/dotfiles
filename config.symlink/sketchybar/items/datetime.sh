#!/bin/env/bash

sketchybar                                                                                    \
  --add item date right                                                                       \
  --set date update_freq=60                                                                   \
             label.font="$FONT:Semibold:7"                                                    \
             align=right                                                                      \
             icon.drawing=off                                                                 \
             y_offset=6                                                                       \
             width=0                                                                          \
             padding_left=$PADDINGS                                                       \
             padding_right=$PADDINGS                                                       \
             script='sketchybar --set $NAME label="$(date "+%a, %b %d")"'                     \
             click_script="open -a Calendar.app"                                              \
  --subscribe date system_woke                                                                \
                   mouse.entered                                                              \
                   mouse.exited                                                               \
                   mouse.exited.global                                                        \
  --add item date.details popup.date                                                          \
  --set date.details "${menu_item_defaults[@]}"                                               \
  --add item clock right                                                                      \
  --set clock update_freq=10                                                                  \
              y_offset=-4                                                                     \
              icon.drawing=off                                                                \
              label.font="$FONT:Bold:9"                                                       \
              padding_left=$PADDINGS                                                       \
              padding_right=$PADDINGS                                                       \
              align=right                                                                     \
              popup.align=right                                                               \
              "${menu_defaults[@]}"                                                           \
              script="$PLUGIN_DIR/nextevent.sh"                                               \
              click_script="sketchybar --set clock popup.drawing=toggle; open -a Calendar.app"\
  --subscribe clock system_woke                                                               \
                    mouse.entered                                                             \
                    mouse.exited                                                              \
                    mouse.exited.global                                                       \
  --add item clock.details popup.clock                                                        \
  --set clock.details "${menu_item_defaults[@]}"