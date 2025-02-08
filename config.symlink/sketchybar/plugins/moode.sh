#!/bin/bash

# Load global styles, colors and icons
# source "$CONFIG_DIR/globalstyles.sh"

# music_item_defaults=(
#   align=center
#   # padding_left=$PADDINGS
#   # padding_right=$PADDINGS
#   label.max_chars=32
# )

# music_cover=(
#   background.image=media.artwork
#   background.image.scale=7
#   background.image.corner_radius=4
#   background.image.padding_left=$PADDINGS
#   background.image.padding_right=$PADDINGS
#   y_offset=-$PADDINGS
# )

# music_artist=(
#   "${separator[@]}"
#   "${music_item_defaults[@]}"
# )

# music_title=(
#   "${music_item_defaults[@]}"
#   label.font.style="Bold"
# )

# music_album=(
#   "${music_item_defaults[@]}"
# )

render_bar_item() {
  sketchybar --set $NAME label="$CURRENT_ARTIST: $CURRENT_SONG"
}

# render_popup() {
#   sketchybar --set music.cover "${music_cover[@]}"   \
#              --set music.artist "${music_artist[@]}" \
#              --set music.title "${music_title[@]}"   \
#              --set music.album "${music_album[@]}"
# }

update() {

  MUSIC=$(ssh pe8er@moode.local 'cat /var/local/www/currentsong.txt'; exit)
  CURRENT_ARTIST=$(echo "$MUSIC" | awk -F 'artist=' '/artist=/{print $2}')
  CURRENT_SONG=$(echo "$MUSIC" | awk -F 'title=' '/title=/{print $2}')
  CURRENT_ALBUM=$(echo "$MUSIC" | awk -F 'album=' '/album=/{print $2}')
  PLAYER_STATE=$(echo "$MUSIC" | awk -F 'state=' '/state=/{print $2}')

  if [ "$PLAYER_STATE" = "play" ]; then
    sketchybar --set $NAME drawing=on icon=􀊆

    render_bar_item
    # render_popup

  else
    sketchybar --set $NAME icon=􀊄
    # popup off
    # sketchybar --set $NAME drawing=off
  fi
  
}

# popup() {
#   sketchybar --set "$NAME" popup.drawing="$1"
# }

playpause() {
  ssh pe8er@moode.local 'mpc toggle'; exit
}
  

case "$SENDER" in
"routine" | "forced")
  update
  ;;
# "mouse.entered")
#   popup on
#   ;;
# "mouse.exited" | "mouse.exited.global")
#   popup off
#   ;;
"mouse.clicked")
  playpause
  ;;
esac