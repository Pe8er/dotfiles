#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))

  space=(
    space=$sid
    padding_left=$(($PADDINGS / 2))
    padding_right=$PADDINGS
    background.height=2
    background.y_offset=-12
    icon.drawing=on
    icon="${SPACE_ICONS[i]}"
    icon.color=$LABEL_COLOR
    icon.padding_left=0
    icon.padding_right=-"$PADDINGS"
    icon.highlight_color=$HIGHLIGHT
    label.padding_right=$PADDINGS
    label.color=$WHITE_50
    label.highlight_color=$HIGHLIGHT
    label.font="sketchybar-app-font:Regular:14.0"
    label.y_offset=-1
    script="$PLUGIN_DIR/space.sh" # && $PLUGIN_DIR/space_windows.sh"
  )

  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid mouse.clicked space_windows_change
done

# space_creator=(
#   icon=􀐇
#   icon.font="$FONT:Regular:14.0"
#   padding_left=$PADDINGS
#   padding_right=$PADDINGS
#   icon.padding_right=$PADDINGS
#   label.drawing=off
#   display=active
#   click_script='yabai -m space --create'
#   script="$PLUGIN_DIR/space_windows.sh"
#   icon.color=$HIGHLIGHT
# )

# sketchybar --add item space_creator left               \
#            --set space_creator "${space_creator[@]}"   \
#            --subscribe space_creator space_windows_change
