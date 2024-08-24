#!/bin/bash

playerState="$(echo "$INFO" | jq -r '.state')"
currentArtist="$(echo "$INFO" | jq -r '.artist')"
currentSong="$(echo "$INFO" | jq -r '.title')"

if [ "$playerState" = "playing" ]; then
  sketchybar --set $NAME drawing=on label="$currentArtist: $currentSong"
# else
#   sketchybar --set $NAME drawing=off
fi