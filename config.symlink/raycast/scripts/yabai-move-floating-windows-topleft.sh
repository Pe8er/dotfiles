#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Move Window -> Top Left
# @raycast.mode silent

# Optional parameters:
# @raycast.icon assets/rectangle.inset.topleft.filled.svg
# @raycast.packageName Yabai

# Documentation:
# @raycast.description Move Floating Window to Top Left of the Screen
# @raycast.author Pior Gajos
# @raycast.authorURL https://github.com/Pe8er

# Get the filename
filename=$(basename "$0")

# Get the last character of the filename, which is '1' in this case
argument=$(echo "${filename%.sh}" | awk -F'-' '{print $NF}')

$HOME/.dotfiles/config.symlink/yabai/move-floating-windows.sh $argument
