#!/bin/bash

window_state() {
  source "$CONFIG_DIR/colors.sh"
  source "$CONFIG_DIR/icons.sh"

  WINDOW=$(yabai -m query --windows --window)
  STACK_INDEX=$(echo "$WINDOW" | jq '.["stack-index"]')

  COLOR=$LABEL_COLOR
  ICON=$YABAI_GRID

  if [ "$(echo "$WINDOW" | jq '.["is-floating"]')" = "true" ]; then
    ICON=$YABAI_FLOAT
    COLOR=$RED
  elif [ "$(echo "$WINDOW" | jq '.["has-fullscreen-zoom"]')" = "true" ]; then
    ICON=$YABAI_FULLSCREEN_ZOOM
    COLOR=$BLUE
  elif [ "$(echo "$WINDOW" | jq '.["has-parent-zoom"]')" = "true" ]; then
    ICON=$YABAI_PARENT_ZOOM
    COLOR=$YELLOW
  elif [[ $STACK_INDEX -gt 0 ]]; then
    LAST_STACK_INDEX=$(yabai -m query --windows --window stack.last | jq '.["stack-index"]')
    ICON=$YABAI_STACK
    LABEL="$(printf "[%s/%s]" "$STACK_INDEX" "$LAST_STACK_INDEX")"
    COLOR=$LABEL_COLOR
  fi

  args=(--animate sin 10 --bar border_color=$COLOR
                         --set $NAME icon.color=$COLOR)

  [ -z "$LABEL" ] && args+=(label.width=20) \
                  || args+=(label="$LABEL" label.width=20)

  [ -z "$ICON" ] && args+=(icon.width=12) \
                 || args+=(icon="$ICON" icon.width=12)

  sketchybar "${args[@]}"
}

windows_on_spaces () {
    /usr/bin/python3 $CONFIG_DIR/plugins/space.py
    window_state
}

mouse_clicked() {
  yabai -m window --toggle float
  window_state
}

windows_on_spaces

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  "forced") windows_on_spaces
  ;;
  "window_focus") window_state 
  ;;
  "windows_on_spaces" | "space_change") windows_on_spaces
  ;;
esac