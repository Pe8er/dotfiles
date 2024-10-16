#!/bin/bash
source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

set_icon() {
  CURRENT_SID=$(yabai -m query --spaces index --space | jq -r '.index')
  FRONT_APP_LABEL_COLOR="$(sketchybar --query space.$CURRENT_SID | jq -r ".label.highlight_color")"
  COLOR=$ICON_COLOR
  WIDTH=28

  WINDOW=$(yabai -m query --windows is-floating,split-type,has-fullscreen-zoom,is-sticky,stack-index --window)
  read -r FLOATING SPLIT FULLSCREEN STICKY STACK_INDEX <<<$(echo "$WINDOW" | jq -rc '.["is-floating", "split-type", "has-fullscreen-zoom", "is-sticky", "stack-index"]')

  if [[ $STACK_INDEX -gt 0 ]]; then
    LAST_STACK_INDEX=$(yabai -m query --windows stack-index --window stack.last | jq '.["stack-index"]')
    ICON=$ICON_YABAI_STACK
    LABEL="$(printf "%s/%s" "$STACK_INDEX" "$LAST_STACK_INDEX")"
    COLOR=$FRONT_APP_LABEL_COLOR
    WIDTH="dynamic"
  elif [[ $FLOATING == "true" ]]; then
    ICON=$ICON_YABAI_FLOAT
  elif [[ $FULLSCREEN == "true" ]]; then
    ICON=$ICON_YABAI_FULLSCREEN_ZOOM
  elif [[ $SPLIT == "vertical" ]]; then
    ICON=$ICON_YABAI_SPLIT_VERTICAL
  elif [[ $SPLIT == "horizontal" ]]; then
    ICON=$ICON_YABAI_SPLIT_HORIZONTAL
  else
    ICON=$ICON_YABAI_GRID
  fi

  args=(--bar border_color=$COLOR --animate tanh 10 --set $NAME icon=$ICON icon.color=$COLOR width=$WIDTH)

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
