#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

# sketchybar --set $NAME icon.highlight=$SELECTED label.highlight=$SELECTED

# if [[ "$SELECTED" == "true" ]]; then
#   sketchybar --set $NAME label.font.style=Bold
# else
#   sketchybar --set $NAME label.font.style=Regular
# fi

if [ "$SELECTED" = "true" ]; then
  args+=(--set $NAME icon.background.y_offset=-12 label.background.y_offset=-12)
else
  args+=(--set $NAME icon.background.y_offset=-24 label.background.y_offset=-24)
fi

args+=(icon.highlight=$SELECTED label.highlight=$SELECTED)

sketchybar --animate tanh 20 "${args[@]}"