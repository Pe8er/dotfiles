#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Plex Now Playing
# @raycast.mode inline
# @raycast.refreshTime 5s
# @raycast.packageName Media

# Optional parameters:
# @raycast.icon 🎵

# Documentation:
# @raycast.description Shows currently playing song from Plex in the menubar
# @raycast.author Pior Gajos
# @raycast.authorURL https://github.com/Pe8er

# Get the output from the original script
output=$(/Users/pe8er/.dotfiles/config.symlink/sketchybar/plugins/plex-now-playing.sh)

# Split the output into components
IFS='|' read -r status artist title artwork <<< "$output"

# Only show output if status is "playing"
if [ "$status" = "playing" ]; then
  echo "$artist - $title"
else
  # Return empty output to hide the menubar item
  exit 0
fi
