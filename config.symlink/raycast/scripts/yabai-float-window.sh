#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Float Window
# @raycast.mode silent

# Optional parameters:
# @raycast.icon assets/yabai.png
# @raycast.packageName Yabai

# Documentation:
# @raycast.description Float a window and resize it (unreleased)
# @raycast.author Pior Gajos
# @raycast.authorURL https://github.com/Pe8er

# <rows>:<cols>:<start-x>:<start-y>:<width>:<height>

yabai -m query --windows id,frame --window |
  jq -er '"yabai -m window \(.id) --toggle float --grid 8:12:3:1:6:5 --resize top_left:\(.frame.w/40):\(.frame.h/40) --resize bottom_right:\(.frame.w/-40):\(.frame.h/-40)"' |
  sh -