#!/usr/bin/env bash

STATE="$(echo "$INFO" | jq -r '.state')"

if [ "$STATE" = "playing" ]; then
  MEDIA="$(echo "$INFO" | jq -r '.artist + ": " + .title')"
  sketchybar --set $NAME label="$MEDIA" drawing=on icon=􀊄
else
  sketchybar --set $NAME drawing=off
fi
