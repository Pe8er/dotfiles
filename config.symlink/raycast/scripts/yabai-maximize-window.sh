#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set Window Full-screen
# @raycast.mode silent

# Optional parameters:
# @raycast.icon assets/yabai.png
# @raycast.packageName Yabai

# Documentation:
# @raycast.description Sets a window full-screen
# @raycast.author Pior Gajos
# @raycast.authorURL https://github.com/Pe8er

windowInfo=$(yabai -m query --windows app,has-fullscreen-zoom --window)

yabai -m window --toggle zoom-fullscreen
sketchybar --trigger update_yabai_icon

appName=$(echo $windowInfo | jq -r '.app')

isFullScreen=$(echo $windowInfo | jq -r '."has-fullscreen-zoom"')

if [[ "$isFullScreen" = "false" ]]; then
  echo "Making $appName full screen"
else
  echo "Moving $appName back to the grid"
fi