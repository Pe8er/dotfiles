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

space_properties="[
  {
    \"icon\": \"$ICON_WEB\",
    \"label\": \"\",
    \"color\": \"teal\"
  },
  {
    \"icon\": \"$ICON_MAIL\",
    \"label\": \"\",
    \"color\": \"orange\"
  },
  {
    \"icon\": \"$ICON_THINGS\",
    \"label\": \"\",
    \"color\": \"yellow\"
  },
  {
    \"icon\": \"$ICON_TERM\",
    \"label\": \"\",
    \"color\": \"cyan\"
  },
  {
    \"icon\": \"$ICON_MUSIC\",
    \"label\": \"\",
    \"color\": \"green\"
  },
  {
    \"icon\": \"$ICON_FIGMA\",
    \"label\": \"\",
    \"color\": \"blue\"
  },
  {
    \"icon\": \"$ICON_DOCUMENTS\",
    \"label\": \"\",
    \"color\": \"purple\"
  }
]"

# Define Spaces
SPACES=(1 2 3 4 5 6 7)

for SID in "${SPACES[@]}"; do
  SIDJSON=$((SID - 1))
  SPACE_COLOR=$(getcolor $(echo "$space_properties" | jq -r .[$SIDJSON].color))
  sketchybar --add space space.$SID left                                         \
             --set space.$SID "${spaces[@]}"                                     \
                   associated_space=$SID                                         \
                   icon=$(echo "$space_properties" | jq -r ".[$SIDJSON].icon")   \
                   label=$(echo "$space_properties" | jq -r ".[$SIDJSON].label") \
                   icon.highlight_color=$SPACE_COLOR                             \
                   label.highlight_color=$SPACE_COLOR                            \
                   script="$PLUGIN_DIR/app_space_simple.sh $SID"                 \
             --subscribe space.$SID mouse.clicked space_change update_yabai_icon space_windows_change
done