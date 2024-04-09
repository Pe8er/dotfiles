#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Float Window
# @raycast.mode silent

# Optional parameters:
# @raycast.icon assets/yabai.png
# @raycast.packageName Yabai

# Documentation:
# @raycast.description Float a window and resize it
# @raycast.author Pior Gajos
# @raycast.authorURL https://github.com/Pe8er

windowInfo=$(yabai -m query --windows id,frame,app,is-floating --window)
appName=$(echo $windowInfo | jq -r '.app')
isFloating=$(echo $windowInfo | jq -r '."is-floating"')
positionX=$(printf "%.0f" $(echo $windowInfo | jq -r '.frame.x'))

echo "$windowInfo" | jq -er '"yabai -m window \(.id) --toggle float --resize top_left:\(.frame.w/40):\(.frame.h/40) --resize bottom_right:\(.frame.w/-40):\(.frame.h/-40)"' |
  sh -

if [ "$isFloating" = "true" ] && [ "$positionX" -lt 500 ]; then
  yabai -m window --swap prev
fi

sketchybar --trigger update_yabai_icon

echo $isFloating / $positionX

if [[ "$isFloating" = "false" ]]; then
  echo "Floating $appName"
else
  echo "Moving $appName back to the grid"
fi
