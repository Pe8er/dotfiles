#!/bin/bash

update() {
  source "$CONFIG_DIR/colors.sh"
  BG_COLOR=$TRANSPARENT
  FG_COLOR=$LIGHT_GREY
  
  space_highlight=(
    background.height=32
    background.color=$BG_COLOR
    background.y_offset=0
    icon.color=$FG_COLOR
    label.color=$FG_COLOR
  )
  
  if [ "$SELECTED" = "true" ]; then
    BG_COLOR=$CONTRAST
    FG_COLOR=$HIGHLIGHT
    
  space_highlight=(
    background.height=2
    background.color=$FG_COLOR
    background.y_offset=-12
    icon.color=$FG_COLOR
    label.color=$FG_COLOR
  )
  
  fi
  sketchybar --animate tanh 20 --set $NAME "${space_highlight[@]}"
}

mouse_clicked() {
  yabai -m space --focus $SID 2>/dev/null
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac