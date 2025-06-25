#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

DND_STATE="focus_off"
COLOR=$ICON_COLOR_INACTIVE

check_state() {
  DND_ENABLED=$(cat ~/Library/DoNotDisturb/DB/Assertions.json | jq .data[0].storeAssertionRecords)
  if [ "$DND_ENABLED" = "null" ]; then
    DND_STATE="focus_off"
    COLOR=$ICON_COLOR_INACTIVE
  else
    COLOR=$ICON_COLOR
    DND_STATE="focus_on"
  fi
  echo $DND_STATE > /tmp/sketchybar_sender
  # echo $NAME: $SENDER / $DND_STATE / $COLOR
}

update_icon() {
  local items=("weather" "aqi" "reminders" "messages" "brew" "mail" "diskmonitor" "diskmonitor.value" "diskmonitor.label" "volume_icon" "volume" "wifi" "notifications" "stress")
  local currentSpace=$(yabai -m query --spaces index --space | jq -r '.index')
      for i in {1..8}; do
        if [ "$i" -ne "$currentSpace" ]; then
            items+=("space.$i")
        fi
    done
  local state_file="/tmp/sketchybar_state"
  # echo $NAME: update_icon: $DND_STATE
  if [ "$DND_STATE" == "focus_on" ]; then
    mv "$state_file" "$state_file.bak" 2>/dev/null || true # Backup old state file if it exists
    for item in "${items[@]}"; do
      state=$(sketchybar --query "$item" | jq -r ".geometry.drawing")
      echo "$item $state" >>"$state_file"
      sketchybar --set "$item" drawing="off"
    done
    # open raycast://extensions/raycast/raycast-focus/toggle-focus-session
  else
    while read -r item state; do
      if [ "$state" = "on" ]; then
        sketchybar --set "$item" drawing="on"
      fi
    done <"$state_file"
    # open raycast://extensions/raycast/raycast-focus/complete-focus-session
  fi

  sketchybar --set $NAME icon.color=$COLOR
}

toggle_dnd() {
  osascript -e 'tell application "System Events" to keystroke "\\" using {control down, shift down, command down, option down}'
}

case "$SENDER" in
"routine" | "forced")
  check_state
  update_icon
  ;;
"focus_on" | "focus_off")
  check_state
  update_icon
  ;;
"mouse.clicked")
  toggle_dnd
  check_state
  update_icon
  ;;
esac
