#!/bin/env/bash

sketchybar                                             \
  --add item dnd right                                 \
  --set dnd script="$PLUGIN_DIR/dnd.sh"                \
  label.drawing=off                                    \
  update_freq=10                                       \
  updates=on                                           \
    --subscribe dnd mouse.clicked