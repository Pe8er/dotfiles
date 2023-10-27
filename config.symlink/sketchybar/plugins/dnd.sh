#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

update() {
    dnd_enabled=$(
        defaults read com.apple.controlcenter "NSStatusItem Visible FocusModes"
    )
    if [ $dnd_enabled -eq 1 ]; then
        sketchybar --set $NAME icon=􀆺
    else
        sketchybar --set $NAME icon=􀆹 icon.color=$WHITE_50
    fi
}

toggle(){
    osascript -e 'tell application "System Events" to keystroke "\\" using {control down, shift down, command down, option down}'
    update
}

case "$SENDER" in
"routine" | "forced")
    update
    ;;
"mouse.clicked")
    toggle
    ;;
esac
