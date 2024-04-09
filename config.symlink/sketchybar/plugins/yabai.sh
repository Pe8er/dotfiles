#!/bin/bash
source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

set_icon() {
  COLOR=$LABEL_COLOR

  WINDOW=$(yabai -m query --windows is-floating,split-type,has-fullscreen-zoom,is-sticky,stack-index --window)
  read -r FLOATING SPLIT FULLSCREEN STICKY STACK_INDEX <<<$(echo "$WINDOW" | jq -rc '.["is-floating", "split-type", "has-fullscreen-zoom", "is-sticky", "stack-index"]')

  if [[ $STACK_INDEX -gt 0 ]]; then
    LAST_STACK_INDEX=$(yabai -m query --windows stack-index --window stack.last | jq '.["stack-index"]')
    ICON=$YABAI_STACK
    LABEL="$(printf "%s/%s" "$STACK_INDEX" "$LAST_STACK_INDEX")"
    COLOR=$(getcolor yellow)
  elif [[ $FLOATING == "true" ]]; then
    ICON=$YABAI_FLOAT
  elif [[ $FULLSCREEN == "true" ]]; then
    ICON=$YABAI_FULLSCREEN_ZOOM
  elif [[ $SPLIT == "vertical" ]]; then
    ICON=$YABAI_SPLIT_VERTICAL
  elif [[ $SPLIT == "horizontal" ]]; then
    ICON=$YABAI_SPLIT_HORIZONTAL
  else
    ICON=$YABAI_GRID
  fi

  args=(--bar border_color=$COLOR --animate tanh 10 --set $NAME icon=$ICON icon.color=$COLOR)

  [ -z "$LABEL" ] && args+=(label.drawing=off) ||
    args+=(label.drawing=on label="$LABEL" label.color=$COLOR)

  [ -z "$ICON" ] && args+=(icon.width=0) ||
    args+=(icon="$ICON")

  sketchybar -m "${args[@]}"
}

mouse_clicked() {
  yabai -m space --layout $(yabai -m query --spaces --space | jq -r 'if .type == "bsp" then "stack" else "bsp" end')
  set_icon
}

case "$SENDER" in
  "mouse.clicked" | "alfred_trigger")
    mouse_clicked
    ;;
  "window_focus" | "front_app_switched" | "update_yabai_icon" | "space_windows_change")
    set_icon
    ;;
esac
