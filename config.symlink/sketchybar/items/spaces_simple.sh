#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

# Defaults
spaces=(
  updates=on                           
  associated_display=1                 
  ignore_association=on
  icon.padding_left=4
  label.padding_right=4
  icon.padding_right=0
)

# Define Spaces
SPACES=(1 2 3 4 5 6 7)

for SID in "${SPACES[@]}"; do
  sketchybar --add space space.$SID left      \
             --set space.$SID "${spaces[@]}"  \
                   associated_space=$SID      \
                   icon=$SID                  \
                   script="$PLUGIN_DIR/app_space_simple.sh $SID" \
             --subscribe space.$SID mouse.clicked space_change update_yabai_icon space_windows_change
done


sketchybar  --set space.1 icon=$ICON_WEB label="Web" icon.highlight_color=$(getcolor red) label.highlight_color=$(getcolor red) \
            --set space.2 icon=$ICON_MAIL label="Comms" icon.highlight_color=$(getcolor orange) label.highlight_color=$(getcolor orange) \
            --set space.3 icon=$ICON_THINGS label="Todo" icon.highlight_color=$(getcolor yellow) label.highlight_color=$(getcolor yellow) \
            --set space.4 icon=$ICON_VSCODIUM label="Code" icon.highlight_color=$(getcolor cyan) label.highlight_color=$(getcolor cyan) \
            --set space.5 icon=$ICON_MUSIC label="Fun"  icon.highlight_color=$(getcolor green) label.highlight_color=$(getcolor green) \
            --set space.6 icon=$ICON_FIGMA label="Design" icon.highlight_color=$(getcolor blue) label.highlight_color=$(getcolor blue) \
            --set space.7 icon=$ICON_PRESENT label="Docs" icon.highlight_color=$(getcolor purple) label.highlight_color=$(getcolor purple)