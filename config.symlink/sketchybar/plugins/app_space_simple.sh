#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

SID=$1
SPACE_COLOR=$2
PREV_SID=$(yabai -m query --spaces --space recent | jq -r '.index')
CURRENT_SID=$(yabai -m query --spaces index --space | jq -r '.index')
FOCUSED_APP=$(yabai -m query --windows app --window | jq -r '.app')

update_colors() {
  if [[ "$SID" == "$PREV_SID" ]]; then
    sketchybar --animate tanh 20                                      \
               --set space.$PREV_SID background.color=$TRANSPARENT    \
                           icon.color=$ICON_COLOR                     \
                           label.color=$LABEL_COLOR
  elif [[ "$SID" == "$CURRENT_SID" ]]; then
    sketchybar --animate tanh 20                                      \
               --set space.$CURRENT_SID background.color=$SPACE_COLOR \
                           icon.color=$BAR_COLOR                      \
                           label.color=$BAR_COLOR
  fi
  # debug "update_colors"
}

update_label() {
  if [[ "$SID" == "$CURRENT_SID" ]]; then
    if [[ -z "$FOCUSED_APP" ]]; then
      LABEL_DRAWING="off"
    else
      LABEL_DRAWING="on"
    fi
    sketchybar --animate tanh 20                                          \
               --set space.$CURRENT_SID label.drawing=$LABEL_DRAWING      \
                                        label="$FOCUSED_APP"
    # debug "update_label"
  fi
}

remove_label() {
  if [[ "$SID" == "$PREV_SID" ]]; then
    sketchybar --animate tanh 20 --set space.$PREV_SID label.drawing=off
    # debug "remove_label"
  fi
}

mouse_clicked() {
  if [[ "$BUTTON" == "right" ]] || [[ "$MODIFIER" == "shift" ]]; then
    SPACE_NAME="${NAME#*.}"
    SPACE_LABEL="$(osascript -e "return (text returned of (display dialog \"Rename space $SPACE_NAME to:\" default answer \"\" with title \"Space Renamer\" buttons {\"Cancel\", \"Rename\"} default button \"Rename\"))")"
    if [[ $? -eq 0 ]]; then
      if [[ "$SPACE_LABEL" == "" ]]; then
        set_space_label ""
      else
        set_space_label "$SPACE_LABEL"
      fi
    fi
  else
    if [[ "$SID" != "$CURRENT_SID" ]]; then
      yabai -m space --focus $SID
    else
      ~/.config/yabai/cycle_windows.sh
    fi
  fi
}

set_space_label() {
  sketchybar --set $NAME label="$@"
}

debug() {
  echo $SENDER "| sid:" $SID "| curr:" $CURRENT_SID "| prev:" $PREV_SID "[$1]"
  # echo $INFO
}

case "$SENDER" in
"routine" | "forced" | "space_change")
  update_colors
  update_label
  remove_label
  ;;
"front_app_switched")
  update_label
  ;;
"mouse.clicked")
  mouse_clicked
  ;;
esac