#!/bin/bash

window_state() {
  source "$CONFIG_DIR/colors.sh"
  source "$CONFIG_DIR/icons.sh"

  WINDOW=$(yabai -m query --windows --window)
  STACK_INDEX=$(echo "$WINDOW" | jq '.["stack-index"]')
  # CURRENTSP=$(yabai -m query --spaces --space | jq '.index')
  WINDOWCOUNT=$(yabai -m query --windows --space | jq -r '.[]."is-floating"' | grep false | wc -l)

  COLOR=$LABEL_COLOR
  ICON=$YABAI_GRID

  if [[ $STACK_INDEX -gt 0 ]]; then
    LAST_STACK_INDEX=$(yabai -m query --windows --window stack.last | jq '.["stack-index"]')
    ICON=$YABAI_STACK
    LABEL="$(printf "[%s of %s]" "$STACK_INDEX" "$LAST_STACK_INDEX")"
    COLOR=$RED
  elif [[ $WINDOWCOUNT -lt 2 ]]; then
    ICON=$YABAI_FULLSCREEN_ZOOM
    COLOR=$HIGHLIGHT
  # elif [ "$(echo "$WINDOW" | jq '.["has-fullscreen-zoom"]')" = "true" ]; then
  #   ICON=$YABAI_FULLSCREEN_ZOOM
  #   COLOR=$GREEN
  elif [ "$(echo "$WINDOW" | jq '.["split-type"]')" == '"vertical"' ]; then
    ICON=$YABAI_SPLIT_VERTICAL
    COLOR=$LABEL_COLOR
  elif [ "$(echo "$WINDOW" | jq '.["split-type"]')" == '"horizontal"' ]; then
    ICON=$YABAI_SPLIT_HORIZONTAL
    COLOR=$LABEL_COLOR
  elif [ "$(echo "$WINDOW" | jq '.["is-floating"]')" = "true" ]; then
    ICON=$YABAI_FLOAT
    COLOR=$HIGHLIGHT
  elif [ "$(echo "$WINDOW" | jq '.["has-parent-zoom"]')" = "true" ]; then
    ICON=$YABAI_PARENT_ZOOM
    COLOR=$BLUE
  fi

  args=(--bar border_color=$COLOR --animate sin 10 --set $NAME icon=$ICON icon.color=$COLOR)

  # [ -z "$LABEL" ] && args+=(label.width=0) \
  #                 || args+=(label="$LABEL" label.width=50)

  # [ -z "$ICON" ] && args+=(icon.width=0) \
  #                || args+=(icon="$ICON" icon.width=30)

  sketchybar -m "${args[@]}"
}


mouse_clicked() {
  # yabai -m query --windows --window
  yabai -m window --toggle zoom-fullscreen
  window_state
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  "window_focus") window_state 
  ;;
esac
