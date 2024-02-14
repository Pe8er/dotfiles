#!/bin/bash

# echo $INFO

update() {
  source "$CONFIG_DIR/colors.sh"

  if [ "$SELECTED" = "true" ]; then
    COLOR=$HIGHLIGHT
    OFFSET=-12
  else
    OFFSET=-20
    COLOR=$TRANSPARENT
  fi

  sketchybar --animate tanh 15                     \
             --set $NAME icon.highlight=$SELECTED  \
                         label.highlight=$SELECTED \
                         background.color=$COLOR   \
                         background.y_offset=$OFFSET
  
  # app="$(echo "$INFO" | jq -r '.apps | keys[0]')"

  # echo UPDATE_SENDER: $SENDER
  # echo UPDATE_APPS: $apps
  
  # FRONT_APP=$(yabai -m query --windows --window | jq -r '.app')
  # space=$(yabai -m query --spaces | jq -r '.[].index')
  # space_prev=$(yabai -m query --spaces --space recent | jq -r '.index')
  # apps="$(yabai -m query --windows --space | jq -r '.[].app')"
  # icon_strip=" "


  # if [ "${apps}" != "" ]; then
  #   while read -r app
  #   do

  #   # if [ "$FRONT_APP" = "$app" ]; then    
  #   #   chevron_left=$($CONFIG_DIR/plugins/icon_map.sh "chevron_left")
  #   #   chevron_right=$($CONFIG_DIR/plugins/icon_map.sh "chevron_right")
  #   # else
  #     chevron_left=""
  #     chevron_right=""
  #   # fi
  #   # icon_strip+=" $chevron_right $($CONFIG_DIR/plugins/icon_map.sh "$app") $chevron_left"

  #   done <<< "${apps}"
  # else
  #   icon_strip=" —"
  # fi
  # echo YABAI SPACE: $space
  # args+=(--set space.$space label="$icon_strip")

  # sketchybar -m "${args[@]}"
  
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
  # space=$(yabai -m query --spaces --space | jq -r '.index')
  # apps="$(yabai -m query --windows --space | jq -r '.[].app')"
  
  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app
    do
      icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
    done <<< "${apps}"
  else
    icon_strip=" —"
  fi
  # echo SKETCHYBAR SPACE: $space
  args+=(--set space.$space label="$icon_strip")

  sketchybar "${args[@]}"
  # update
}

case "$SENDER" in
  "mouse.clicked")
  mouse_clicked
  ;;
  "yabai_window_created" | "yabai_window_destroyed" | "yabai_window_focused" | "yabai_application_terminated")
  create_icons
  ;;
  *) update
  ;;
esac