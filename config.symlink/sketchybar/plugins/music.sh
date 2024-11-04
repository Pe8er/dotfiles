#!/bin/bash

player="$(echo "$INFO" | jq -r '.app')"
playerState="$(echo "$INFO" | jq -r '.state')"
currentArtist="$(echo "$INFO" | jq -r '.artist')"
currentSong="$(echo "$INFO" | jq -r '.title')"

if [[ "$player" = "Music" || "$player" = "Spotify" ]]; then
  if [ "$playerState" = "playing" ]; then
    sketchybar --set $NAME drawing=on label="$currentArtist: $currentSong" background.image=media.artwork
  fi
else
  sketchybar --set $NAME drawing=off
fi