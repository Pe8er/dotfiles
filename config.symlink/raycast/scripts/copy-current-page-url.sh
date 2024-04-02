#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Current Page URL
# @raycast.mode silent
# @raycast.packageName Arc Browser
#
# Optional parameters:
# @raycast.icon 🧭
#
# Documentation:
# @raycast.description This script copies URL of currently opened page in Arc Browser into clipboard.
# @raycast.author Piotr Gajos
# @raycast.authorURL https://github.com/pe8er

osascript -e 'tell application "Arc" to get URL of active tab of first window' | pbcopy
echo "Copied"