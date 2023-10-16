#!/bin/env/bash

sketchybar \
  --add item date right \
  --set date update_freq=60 \
  label.font="$FONT:Semibold:7" \
  align=right \
  icon.drawing=off \
  y_offset=6 \
  width=0 \
  script='sketchybar --set $NAME label="$(date "+%a, %b %d")"' \
  click_script="open -a Calendar.app" \
  --subscribe date system_woke \
  \
  --add item clock right \
  --set clock update_freq=10 \
  y_offset=-4 \
  icon.drawing=off \
  label.font="$FONT:Bold:9" \
  align=right \
  script='sketchybar --set $NAME label="$(date "+%I:%M %p")"' \
  click_script="open -a Calendar.app" \
  --subscribe clock system_woke