#!/bin/env/bash

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))

  space=(
    associated_space=$sid
    icon="${SPACE_ICONS[i]}"
    label.font="sketchybar-app-font:Regular:14.0"
    label.y_offset=-1
    label.drawing=off
    script="$PLUGIN_DIR/space.sh"
  )

  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid mouse.clicked
done

# sketchybar \
# --add item spacer_chevron left \
#   --set spacer_chevron label.drawing=off \
#   icon=􀆊 \
#   icon.padding_left=0 \
#   \
#   --add item front_app left \
#   --set front_app script="$PLUGIN_DIR/front_app.sh" \
#   icon.drawing=off \
#   label.font="$FONT:Bold:12.0" \
#   --subscribe front_app front_app_switched