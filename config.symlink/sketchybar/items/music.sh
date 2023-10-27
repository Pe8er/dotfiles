#!/bin/env/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

music=(
  "${bracket_defaults[@]}"
  script="$PLUGIN_DIR/music.sh"
  popup.align=right
  background.padding_right=$PADDINGS
  icon=$MUSIC
  label="Loading…"
  background.image.scale=0.1
  background.image.corner_radius=$PADDINGS
  background.image.y_offset=-$PADDINGS
  background.image.border_width=2
  background.image.border_color=$HIGHLIGHT
  icon.padding_left=32
  updates=on
  --subscribe music media_change
  --subscribe music mouse.entered
                    mouse.clicked
                    mouse.exited
                    mouse.exited.global
)

sketchybar                                                                            \
  --add item music right                                                              \
  --set      music "${music[@]}"                                                      \
  --set      music "${menu_defaults[@]}"                                              \
  --add item music.cover popup.music                                                  \
       --set music.cover background.image=$CONFIG_DIR/plugins/music/Cover-Default.png \
  --add item music.artist popup.music                                                 \
  --add item music.title popup.music                                                  \
  --add item music.album popup.music