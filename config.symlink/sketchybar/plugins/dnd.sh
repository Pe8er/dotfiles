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
  [ "$SENDER" = "focus_off" ] && COLOR=$ICON_COLOR_INACTIVE || COLOR=$ICON_COLOR
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
