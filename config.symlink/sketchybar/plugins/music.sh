
# Music Widget for Sketchybar
# Displays currently playing music from various players (Music, Spotify, TIDAL, PlexAmp)
# Supports click actions for controlling playback
#
# Dependencies:
# - jq: for JSON parsing
# - sketchybar: for displaying the widget
# - plex-now-playing.sh: for Plex integration

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

log_debug() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') [DEBUG] $1"
}

update_widget() {
  
  # log_debug "SENDER: $SENDER"
  # log_debug "INFO: $INFO"

  if [[ -z "$INFO" ]]; then
    PLEX_INFO="$("$CONFIG_DIR/plugins/plex-now-playing.sh")"
  fi

  if [[ -n "$PLEX_INFO" && "$PLEX_INFO" != *"Error"* && "$PLEX_INFO" != *"Nothing"* ]]; then
    IFS='|' read -r PLAYER_STATE CURRENT_ARTIST CURRENT_SONG ARTWORK <<<"$PLEX_INFO"
  elif [[ -n "$INFO" ]]; then
    PLAYER_STATE="$(echo "$INFO" | jq -r '.state // empty')"
    PLAYER="$(echo "$INFO" | jq -r '.app // empty')"
    CURRENT_ARTIST="$(echo "$INFO" | jq -r '.artist // empty')"
    CURRENT_SONG="$(echo "$INFO" | jq -r '.title // empty')"
    if [[ "$PLAYER" != "Plexamp" ]]; then
      ARTWORK=media.artwork
    fi
  else
    PLAYER_STATE="stopped"
    CURRENT_ARTIST="Nothing is playing"
    CURRENT_SONG=""
  fi

  # log_debug "CURRENT_ARTIST: $CURRENT_ARTIST"
  # log_debug "PLAYER: $PLAYER"
  # log_debug "PLAYER_STATE: $PLAYER_STATE"

  if [[ "$PLAYER_STATE" == "playing" ]]; then
    args=(drawing=on label="${CURRENT_ARTIST}: ${CURRENT_SONG}" background.image="${ARTWORK}")
  else
    args=(drawing=off)
  fi

  sketchybar --set "$NAME" "${args[@]}"
}

handle_mouse_click() {
  case "$MODIFIER" in
  "cmd")
    open -a "Plexamp"
    ;;
  "shift")
    open raycast://extensions/douo/global-media-key/next
    ;;
  "none")
    open raycast://extensions/douo/global-media-key/play
    ;;
  esac
}

# Main event handler
case "$SENDER" in
"routine" | "forced")
  update_widget
  ;;
"mouse.clicked")
  handle_mouse_click
  ;;
*)
  echo "Unknown sender: $SENDER"
  exit 1
  ;;
esac
