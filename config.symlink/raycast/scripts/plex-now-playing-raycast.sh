#!/usr/bin/env bash
# Raycast Script Command
# @raycast.schemaVersion 1
# @raycast.title Plex Now Playing
# @raycast.mode compact
# @raycast.refreshTime 5s
# @raycast.icon 🎵
# @raycast.packageName Media
#
# This script displays the currently playing song from Plex in the menubar.
# It hides itself if nothing is playing.

# Path to your original script that outputs: status|artist|title|artwork
SCRIPT_PATH="$HOME/.dotfiles/config.symlink/raycast/scripts/plex-now-playing.sh"

# Run the script and capture output
OUTPUT=$(bash "$SCRIPT_PATH")

# Parse output
STATUS=$(echo "$OUTPUT" | cut -d'|' -f1)
ARTIST=$(echo "$OUTPUT" | cut -d'|' -f2)
TITLE=$(echo "$OUTPUT" | cut -d'|' -f3)

# Only show if status is 'playing'
if [ "$STATUS" = "playing" ]; then
  echo "$ARTIST - $TITLE"
else
  exit 0
fi
