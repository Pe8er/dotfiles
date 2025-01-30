#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

check_state() {
  # DND_ENABLED=$(cat ~/Library/DoNotDisturb/DB/Assertions.json | jq .data[0].storeAssertionRecords)

  # Alternate SLOW method:
  DND_ENABLED=$(defaults read com.apple.controlcenter "NSStatusItem Visible FocusModes")
  [ "$DND_ENABLED" = 0 ] && COLOR=$ICON_COLOR_INACTIVE || COLOR=$ICON_COLOR
  sketchybar --set $NAME icon.color=$COLOR
}

update_icon() {
  local items=("weather" "aqi" "reminders" "messages" "brew" "mail" "diskmonitor" "volume_icon" "volume" "wifi" "notifications")
  local currentSpace=$(yabai -m query --spaces index --space | jq -r '.index')
      for i in {1..7}; do
        if [ "$i" -ne "$currentSpace" ]; then
            items+=("space.$i")
        fi
    done
  local state_file="/tmp/sketchybar_state"
  echo $SENDER >/tmp/sketchybar_sender
  if [ "$SENDER" = "focus_on" ]; then
    COLOR=$ICON_COLOR
    mv "$state_file" "$state_file.bak" 2>/dev/null || true # Backup old state file if it exists
    for item in "${items[@]}"; do
      state=$(sketchybar --query "$item" | jq -r ".geometry.drawing")
      echo "$item $state" >>"$state_file"
      sketchybar --set "$item" drawing="off"
    done
    open raycast://extensions/raycast/raycast-focus/start-focus-session
  else
    COLOR=$ICON_COLOR_INACTIVE
    while read -r item state; do
      if [ "$state" = "on" ]; then
        sketchybar --set "$item" drawing="on"
      fi
    done <"$state_file"
    open raycast://extensions/raycast/raycast-focus/toggle-focus-session
  fi

  # echo $SENDER $DRAWINGSTATE

  sketchybar --set $NAME icon.color=$COLOR
}

toggle_dnd() {
  osascript -e 'tell application "System Events" to keystroke "\\" using {control down, shift down, command down, option down}'
}

case "$SENDER" in
"routine" | "forced")
  check_state
  ;;
"focus_on" | "focus_off")
  update_icon
  ;;
"mouse.clicked")
  toggle_dnd
  ;;
esac
