#!/bin/bash

update() {
  source "$CONFIG_DIR/colors.sh"
  COLOR=$TRANSPARENT
  if [ "$SELECTED" = "true" ]; then
    COLOR=$HIGHLIGHT
  fi
  sketchybar --set $NAME icon.highlight=$SELECTED \
                         label.highlight=$SELECTED \
                         background.color=$COLOR
}

set_space_label() {
  sketchybar --set $NAME icon="$@"
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ] || [ "$MODIFIER" = "shift" ]; then
    SPACE_LABEL="$(osascript -e "return (text returned of (display dialog \"Give a name to space $NAME:\" default answer \"\" with icon note buttons {\"Cancel\", \"Continue\"} default button \"Continue\"))")"
    if [ $? -eq 0 ]; then
      if [ "$SPACE_LABEL" = "" ]; then
        set_space_label "${NAME:6}"
      else
        set_space_label "${NAME:6} $SPACE_LABEL"
      fi
    fi
  else
    yabai -m space --focus $SID 2>/dev/null
  fi
}

create_icons() {
  args=(--animate sin 10)

  space="$(echo "$INFO" | jq -r '.space')"
  apps="$(echo "$INFO" | jq -r '.apps | keys[]')"

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app
    do
      icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
    done <<< "${apps}"
  else
    icon_strip=" —"
  fi
  args+=(--set space.$space label="$icon_strip")

  sketchybar -m "${args[@]}"
}

case "$SENDER" in
  "mouse.clicked")
  mouse_clicked
  ;;
  "space_windows_change")
  create_icons
  ;;
  *) update
  ;;
esac