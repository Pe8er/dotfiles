#!/bin/env/bash

sketchybar                                                     \
  --add alias "Control Center,Battery" right                   \
  --rename "Control Center,Battery" battery                    \
  --set battery "${icon_defaults[@]}"                          \
  update_freq=10                                               \
  "${menu_defaults[@]}"                                        \
  popup.align=right                                            \
  click_script="sketchybar --set battery popup.drawing=toggle" \
  script="$PLUGIN_DIR/battery.sh"                              \
  updates=when_shown                                           \
  --subscribe battery power_source_change                      \
                      mouse.entered                            \
                      mouse.exited                             \
                      mouse.exited.global                      \
  --add item battery.details popup.battery                     \
  --set battery.details "${menu_item_defaults[@]}"