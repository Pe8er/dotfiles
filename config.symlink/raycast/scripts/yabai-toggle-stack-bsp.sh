#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Stack / BSP Layout
# @raycast.mode silent

# Optional parameters:
# @raycast.icon assets/yabai.png
# @raycast.packageName Yabai

# Documentation:
# @raycast.description Toggle between Stack and BSP layouts
# @raycast.author Pior Gajos
# @raycast.authorURL https://github.com/Pe8er

sketchybar --trigger alfred_trigger
sleep 0.5
layout=$(yabai -m query --spaces type --space | jq -r .type)
echo "Layout: $layout"
sleep 0.5
sketchybar --trigger update_yabai_icon

