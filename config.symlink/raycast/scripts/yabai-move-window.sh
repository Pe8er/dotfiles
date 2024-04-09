#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Move Window to Another Space
# @raycast.mode silent

# Optional parameters:
# @raycast.icon assets/rectangle.trailinghalf.inset.filled.arrow.trailing.svg
# @raycast.argument1 { "type": "text", "placeholder": "Space number (1-7)" }
# @raycast.packageName Yabai

# Documentation:
# @raycast.description Move focused window to another space
# @raycast.author Pior Gajos
# @raycast.authorURL https://github.com/Pe8er

yabai -m window --space "$1" --focus
