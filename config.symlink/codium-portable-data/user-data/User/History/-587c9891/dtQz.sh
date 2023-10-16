#!/bin/sh

# Load defined icons
source "$CONFIG_DIR/icons.sh"

# Load defined colors
source "$CONFIG_DIR/colors.sh"

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

PREVIOUS_ALBUM=""
CURRENT_ALBUM=""

music_item_defaults=(
  label.font="$FONT:Regular:13"
  width=234
  align=center
  padding_left=8
  padding_right=8
)

music_cover=(
  label.drawing=off
  icon.drawing=off
  background.image.scale=0.5
)

music_artist=(
  "${separator[@]}"
  "${music_item_defaults[@]}"
)

music_title=(
  "${music_item_defaults[@]}"
  label.font.style="Bold"
)

music_album=(
  "${music_item_defaults[@]}"
)

render_bar_item() {
  sketchybar --set $NAME label="$CURRENT_ARTIST: $CURRENT_SONG" label.padding_right=8
}

render_popup() {
  sketchybar --set music.cover "${music_cover[@]}" \
             --set music.artist "${music_artist[@]}" \
             --set music.title "${music_title[@]}" \
             --set music.album "${music_album[@]}"
}

update(){
  CURRENT_ARTIST="$(echo "$INFO" | jq -r '.artist')"
  CURRENT_SONG="$(echo "$INFO" | jq -r '.title')"
  PREVIOUS_ALBUM="$(cat "$CONFIG_DIR/plugins/music/album.txt")"
  CURRENT_ALBUM="$(echo "$INFO" | jq -r '.album')"
  echo "$CURRENT_ALBUM" > "$CONFIG_DIR/plugins/music/album.txt"
  

  if [ "$CURRENT_ALBUM" != "$PREVIOUS_ALBUM" ] || [ "$CURRENT_COVER" == "" ]; then
    CURRENT_COVER=$(osascript $CONFIG_DIR/plugins/music/Get-Artwork.scpt)
  fi

  if [ $(printf "$CURRENT_ARTIST" | wc -c) -ge '30' ]; then
    CURRENT_ARTIST=${CURRENT_ARTIST:0:30}"…"
  fi

  if [ $(printf "$CURRENT_SONG" | wc -c) -ge '27' ]; then
    CURRENT_SONG=${CURRENT_SONG:0:27}"…"
  fi

  if [ $(printf "$CURRENT_ALBUM" | wc -c) -ge '33' ]; then
    CURRENT_ALBUM=${CURRENT_ALBUM:0:33}"…"
  fi

  # for i in ["$CURRENT_ARTIST", "$CURRENT_SONG", "$CURRENT_ALBUM"]; do
  #     if [ $(printf "$i" | wc -c) -ge '26' ]; then
  #       i = ${$i:0:26}"…"
  #     fi
  # done

  sketchybar --set music.cover background.image="$CURRENT_COVER" \
             --set music.artist label="$CURRENT_ARTIST" \
             --set music.title label="$CURRENT_SONG" \
             --set music.album label="$CURRENT_ALBUM"

  render_bar_item
  render_popup
}

popup() {
  sketchybar --set "$NAME" popup.drawing="$1"
}

case "$SENDER" in
"routine" | "forced" | "media_change")
  update
  ;;
"mouse.entered")
  popup on
  ;;
"mouse.exited" | "mouse.exited.global")
  popup off
  ;;
"mouse.clicked")
  popup toggle
  ;;
esac