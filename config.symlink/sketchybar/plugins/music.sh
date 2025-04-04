#!/bin/bash

PLAYER="$(echo "$INFO" | jq -r '.app')"
PLAYERSTATE="$(echo "$INFO" | jq -r '.state')"
CURRENTARTIST="$(echo "$INFO" | jq -r '.artist')"
CURRENTSONG="$(echo "$INFO" | jq -r '.title')"

updateWidget() {
  if [[ "$PLAYER" = "Music" || "$PLAYER" = "Spotify" || "$PLAYER" = "TIDAL" ]]; then
    ARGS=(drawing=on label="$CURRENTARTIST: $CURRENTSONG" background.image=media.artwork)
  else
    ARGS=(drawing=off)
  fi

  sketchybar --set $NAME "${ARGS[@]}"
}

mouseClicked() {
  if [[ "$MODIFIER" == "cmd" ]]; then
    open -a "$PLAYER"
  elif [[ "$MODIFIER" == "shift" ]]; then
    open raycast://extensions/douo/global-media-key/next
  elif [[ "$MODIFIER" == "none" ]]; then
    open raycast://extensions/douo/global-media-key/play
  fi
}

case "$SENDER" in
"routine" | "forced" | "media_change")
  updateWidget
  ;;
"mouse.clicked")
  mouseClicked
  ;;
esac
