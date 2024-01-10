#!/bin/sh

sketchybar                                          \
--add item front_app left                           \
           --set front_app                          \
                 script="$PLUGIN_DIR/front_app.sh"  \
                 icon.drawing=off                   \
                 icon.background.drawing=off        \
                 icon.background.color=0x00000000   \
                 label.font.style=Bold              \
                 icon.background.image.scale=0.5    \
                 --subscribe front_app front_app_switched