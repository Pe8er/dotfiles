#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Window Split
# @raycast.mode silent

# Optional parameters:
# @raycast.icon assets/yabai.png
# @raycast.packageName Yabai

# Documentation:
# @raycast.description Toggle horizontal / vertical split
# @raycast.author Pior Gajos
# @raycast.authorURL https://github.com/Pe8er

yabai -m window --toggle split
sketchybar --trigger update_yabai_icon
