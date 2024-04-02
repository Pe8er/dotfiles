#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Decrease Window Size
# @raycast.mode silent

# Optional parameters:
# @raycast.icon assets/yabai.png
# @raycast.packageName Yabai

# Documentation:
# @raycast.description Decreases size of focused window
# @raycast.author Pior Gajos
# @raycast.authorURL https://github.com/Pe8er

# Get the filename without extension
filename=$(basename "$0" .sh)

# Extract the variable part by splitting the filename
direction=${filename##*-}

~/.config/yabai/resize_window.sh "$direction"