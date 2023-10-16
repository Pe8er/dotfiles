#!/bin/env/bash

sketchybar \
  --add alias "Control Center,Battery" right \
  --rename "Control Center,Battery" battery.alias \
  --set battery.alias "${icon_defaults[@]}" \
  "${menu_defaults[@]}" \
  popup.align=right \
  popup.y_offset=$PADDINGS \
  click_script="sketchybar --set battery.alias popup.drawing=toggle" \
  script="$PLUGIN_DIR/battery.sh" \
  updates=when_shown \
  --subscribe battery.alias power_source_change \
                            mouse.entered \
                            mouse.exited \
                            mouse.exited.global \
  --add item battery.alias.details popup.battery.alias \
  --set battery.alias.details "${menu_item_defaults[@]}"