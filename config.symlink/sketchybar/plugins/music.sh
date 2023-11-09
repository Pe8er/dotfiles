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
  align=center
  padding_left=$PADDINGS
  padding_right=$PADDINGS
  label.max_chars=32
)

music_cover=(
  background.image.scale=0.468
  background.image.corner_radius=4
  background.image.padding_left=$PADDINGS
  background.image.padding_right=$PADDINGS
  y_offset=-$PADDINGS
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
  sketchybar --set $NAME label="$CURRENT_ARTIST: $CURRENT_SONG"
}

render_popup() {
  sketchybar --set music.cover "${music_cover[@]}"   \
             --set music.artist "${music_artist[@]}" \
             --set music.title "${music_title[@]}"   \
             --set music.album "${music_album[@]}"
}

update() {
  CURRENT_ARTIST="$(echo "$INFO" | jq -r '.artist')"
  CURRENT_SONG="$(echo "$INFO" | jq -r '.title')"
  PREVIOUS_ALBUM="$(cat "$CONFIG_DIR/plugins/music/album.txt")"
  CURRENT_ALBUM="$(echo "$INFO" | jq -r '.album')"
  PLAYER_STATE="$(echo "$INFO" | jq -r '.state')"
  echo "$CURRENT_ALBUM" > "$CONFIG_DIR/plugins/music/album.txt"

  
  if [ "$CURRENT_ALBUM" != "$PREVIOUS_ALBUM" ] || [ "$CURRENT_COVER" == "" ]; then
    CURRENT_COVER=$(osascript $CONFIG_DIR/plugins/music/Get-Artwork.applescript)
  fi

  # if [ $(printf "$CURRENT_ARTIST" | wc -c) -ge '30' ]; then
  #   CURRENT_ARTIST=${CURRENT_ARTIST:0:30}"…"
  # fi

  # if [ $(printf "$CURRENT_SONG" | wc -c) -ge '27' ]; then
  #   CURRENT_SONG=${CURRENT_SONG:0:27}"…"
  # fi

  # if [ $(printf "$CURRENT_ALBUM" | wc -c) -ge '33' ]; then
  #   CURRENT_ALBUM=${CURRENT_ALBUM:0:33}"…"
  # fi

  if [ "$PLAYER_STATE" = "playing" ]; then
    sketchybar --set music drawing=on                               \
               --set music.cover background.image="$CURRENT_COVER"  \
               --set music background.image="$CURRENT_COVER"        \
               --set music.artist label="$CURRENT_ARTIST"           \
               --set music.title label="$CURRENT_SONG"              \
               --set music.album label="$CURRENT_ALBUM"

    render_bar_item
    render_popup
  else
    sketchybar --set music drawing=off
  fi

  # for i in ["$CURRENT_ARTIST", "$CURRENT_SONG", "$CURRENT_ALBUM"]; do
  #     if [ $(printf "$i" | wc -c) -ge '26' ]; then
  #       i = ${$i:0:26}"…"
  #     fi
  # done

  
}

popup() {
  sketchybar --set "$NAME" popup.drawing="$1"
}

playpause() {
  osascript -e 'tell application "Music" to playpause'
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
  playpause
  ;;
esac