#!/bin/env/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

music=(
  "${bracket_defaults[@]}"
  script="$PLUGIN_DIR/music.sh"
  popup.align=right
  background.padding_right=$PADDINGS
  icon=$MUSIC
  label="Loading…"
  updates=on
  --subscribe music media_change
  --subscribe music mouse.entered
                    mouse.clicked
                    mouse.exited
                    mouse.exited.global

)

sketchybar                                                                             \
  --add item  music right                                                              \
  --set       music "${music[@]}"                                                      \
  --set       music "${menu_defaults[@]}"                                              \
  --add item  music.cover popup.music                                                  \
       --set  music.cover background.image=$CONFIG_DIR/plugins/music/Cover-Default.png \
  --add item  music.artist popup.music                                                 \
       --set  music.artist label="Loading…"                                            \
  --add item  music.title popup.music                                                  \
       --set  music.title label="Loading…"                                             \
  --add item  music.album popup.music                                                  \
       --set  music.album label="Loading…"