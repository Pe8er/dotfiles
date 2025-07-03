#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Aerospace: Float Forever
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName com.pe8er.aerospace

# Documentation:
# @raycast.author Pior Gajos
# @raycast.authorURL https://github.com/Pe8er

# Path to your Aerospace config
CONFIG_FILE=~/.dotfiles/config.symlink/aerospace/aerospace.toml

# Marker comment to insert after
COMMENT_MARKER="# --- Float Windows ---"

# Command to get currently focused app's bundle ID
APP_ID=$(aerospace list-windows --focused --format '%{app-bundle-id}')

# TOML line to insert
NEW_ENTRY="  { if.app-id = '${APP_ID}', run = 'layout floating' },"

# Find the line number of the COMMENT_MARKER
LINE_NUM=$(grep -nF "$COMMENT_MARKER" "$CONFIG_FILE" | cut -d: -f1)



# Insert after line 82
# awk -v new_entry="$NEW_ENTRY" 'NR==82{print; print new_entry; next}1' "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
  awk -v line_num="$LINE_NUM" -v new_entry="$NEW_ENTRY" 'NR==line_num{print; print new_entry; next}1' "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"

# Apply the layout and reload config
aerospace layout floating
aerospace reload-config