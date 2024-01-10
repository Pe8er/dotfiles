#!/bin/sh

sketchybar                                         \
--add item front_app left                          \
           --set front_app                         \
                 script="$PLUGIN_DIR/front_app.sh" \
                 icon.drawing=off                  \
                 label.padding_left=0              \
                 label.font.style=Bold             \
                 icon.background.image.scale=0.5   \
                 --subscribe front_app front_app_switched