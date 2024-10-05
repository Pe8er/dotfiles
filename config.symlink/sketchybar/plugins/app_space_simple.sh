#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

SID=$1

update_icons() {
  sketchybar --animate tanh 10                         \
             --set space.$SID icon.highlight=$SELECTED \
                              label.highlight=$SELECTED
}

mouse_clicked() {
  if [[ "$BUTTON" == "right" ]] || [[ "$MODIFIER" == "shift" ]]; then
    SPACE_NAME="${NAME#*.}"
    SPACE_LABEL="$(osascript -e "return (text returned of (display dialog \"Rename space $SPACE_NAME to:\" default answer \"\" with title \"Space Renamer\" buttons {\"Cancel\", \"Rename\"} default button \"Rename\"))")"
    if [[ $? -eq 0 ]]; then
      if [[ "$SPACE_LABEL" == "" ]]; then
        set_space_label "${NAME:6}"
      else
        set_space_label "${NAME:6} $SPACE_LABEL"
      fi
    fi
  elif [[ "$MODIFIER" == "cmd" ]]; then
    ~/.config/yabai/cycle_windows.sh
  else
    yabai -m space --focus $SID
  fi
}

set_space_label() {
  sketchybar --set $NAME label="$@"
}

case "$SENDER" in
"routine" | "forced" | "space_windows_change" | "space_change")
  update_icons
  ;;
"mouse.clicked")
  mouse_clicked
  ;;
esac
