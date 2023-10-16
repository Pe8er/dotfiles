#!/bin/env/bash

sketchybar \
  --add item dndindicator right \
  --set dndindicator script="$PLUGIN_DIR/dndindicator.sh" \
  label.drawing=off \
  update_freq=10 \
  updates=on \
