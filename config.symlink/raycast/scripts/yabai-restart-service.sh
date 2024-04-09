#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Restart Yabai Service
# @raycast.mode silent

# Optional parameters:
# @raycast.icon assets/yabai.png
# @raycast.packageName Yabai

# Documentation:
# @raycast.description Restarts Yabai service
# @raycast.author Pior Gajos
# @raycast.authorURL https://github.com/Pe8er

yabai --restart-service

echo "Restarting Yabai service…"