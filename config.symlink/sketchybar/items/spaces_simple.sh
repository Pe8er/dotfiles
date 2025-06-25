#!/bin/bash

# Default styles
spaces=(
  ignore_association=on
  updates=on                           
  associated_display=1                 
  background.height=16
  icon.padding_left=$PADDINGS
  icon.padding_right=$PADDINGS
  label.drawing=off
  label.padding_left=0
  label.padding_right=$PADDINGS
)

# Define spaces
space_properties="[
  {
    \"icon\": \"$ICON_WEB\",
    \"label\": \"\",
    \"color\": \"cyan\"
  },
  {
    \"icon\": \"$ICON_MAIL\",
    \"label\": \"\",
    \"color\": \"orange\"
  },
  {
    \"icon\": \"$ICON_FIGMA\",
    \"label\": \"\",
    \"color\": \"green\"
  },
  {
    \"icon\": \"$ICON_FINDER\",
    \"label\": \"\",
    \"color\": \"maroon\"
  },
  {
    \"icon\": \"$ICON_TERM\",
    \"label\": \"\",
    \"color\": \"yellow\"
  },
  {
    \"icon\": \"$ICON_MEDIA\",
    \"label\": \"\",
    \"color\": \"red\"
  },
  {
    \"icon\": \"$ICON_DOCUMENTS\",
    \"label\": \"\",
    \"color\": \"purple\"
  },
  {
    \"icon\": \"$ICON_PHOTOSHOP\",
    \"label\": \"\",
    \"color\": \"blue\"
  }
]"

SPACE_COUNT=$(echo "$space_properties" | jq '. | length')

for (( SID=1; SID<=SPACE_COUNT; SID++ )); do
  SIDJSON=$((SID - 1))
  SPACE_COLOR=$(getcolor $(echo "$space_properties" | jq -r .[$SIDJSON].color))
  sketchybar --add space space.$SID left                                         \
             --set space.$SID "${spaces[@]}"                                     \
                   associated_space=$SID                                         \
                   icon=$(echo "$space_properties" | jq -r ".[$SIDJSON].icon")   \
                   label=$(echo "$space_properties" | jq -r ".[$SIDJSON].label") \
                   icon.highlight_color=$SPACE_COLOR                             \
                   label.highlight_color=$SPACE_COLOR                            \
                   script="$PLUGIN_DIR/app_space_simple.sh $SID $SPACE_COLOR"    \
             --subscribe space.$SID mouse.clicked space_change front_app_switched
done