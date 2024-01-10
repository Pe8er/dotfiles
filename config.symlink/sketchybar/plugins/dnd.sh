#!/bin/sh

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

update() {
    dnd_enabled=$(cat ~/Library/DoNotDisturb/DB/Assertions.json | jq .data[0].storeAssertionRecords)
    # alternate method: defaults read com.apple.controlcenter "NSStatusItem Visible FocusModes"
    ICON=􀆺

    if [ "$dnd_enabled" = "null" ]; then
        COLOR=$WHITE_25
        # echo $NAME: "Disabled"
    else
        COLOR=$WHITE
        # echo $NAME: "Enabled"
    fi

    sketchybar --set $NAME icon=$ICON icon.color=$COLOR
}

toggle() {
    osascript -e 'tell application "System Events" to keystroke "\\" using {control down, shift down, command down, option down}'
}

case "$SENDER" in
"routine" | "forced" | "focus_on" | "focus_off")
    update
    ;;
"mouse.clicked")
    toggle
    ;;
esac
