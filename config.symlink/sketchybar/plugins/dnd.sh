#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

update() {
    dnd_enabled=$(
        defaults read com.apple.controlcenter "NSStatusItem Visible FocusModes"
    )

    if [ $dnd_enabled -eq 1 ]; then
        ICON=􀆺
        COLOR=$WHITE
    else
        ICON=􀆹
        COLOR=$WHITE_25
    fi

    sketchybar --set $NAME icon=$ICON icon.color=$COLOR
}

toggle() {
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
