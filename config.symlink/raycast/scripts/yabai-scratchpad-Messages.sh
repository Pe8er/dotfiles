#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Scratchpad: Messages
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /System/Applications/Messages.app/Contents/Resources/AppIcon.icns
# @raycast.packageName Yabai

# Documentation:
# @raycast.description Toggle Messages Scratchpad
# @raycast.author Pior Gajos
# @raycast.authorURL https://github.com/Pe8er

# Get app name from filename
appName=$(echo $(basename "$0") | sed -E 's/^[^-]+-[^-]+-(.*)\.sh$/\1/')

yabai -m window --toggle "$appName" || open -a "$appName"