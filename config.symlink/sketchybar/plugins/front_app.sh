#!/bin/bash

# # Some events send additional information specific to the event in the $INFO
# # variable. E.g. the front_app_switched event sends the name of the newly
# # focused application in the $INFO variable:
# # https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting


# CURRENT_APP=$(yabai -m query --windows app --window | jq -r '.app')
# CURRENT_SID=$(yabai -m query --spaces index --space | jq -r '.index')
# FRONT_APP_LABEL_COLOR="$(sketchybar --query space.$CURRENT_SID | jq -r ".label.highlight_color")"

# if [[ $CURRENT_APP ]]; then
#   ICON=􀆊
# else
#   ICON=""
# fi

# sketchybar --set $NAME icon=$ICON label="$CURRENT_APP" label.color=$FRONT_APP_LABEL_COLOR

WIN_TITLE_FILE='window_title.dat'
OLD_TITLE=$(sketchybar --query front_app | jq -r ".label.value")
  
  WINDOW_TITLE=$(/opt/homebrew/bin/yabai -m query --windows --window | jq -r '.title')
  
  if [[ $WINDOW_TITLE = "" ]]; then
    WINDOW_TITLE=$(/opt/homebrew/bin/yabai -m query --windows --window | jq -r '.app')
  fi
  
  # OLD_TITLE=$(cat $WIN_TITLE_FILE)
  
  if [[ $WINDOW_TITLE = $OLD_TITLE ]]; then
    exit 0
  else
    sketchybar --animate sin 5 --set front_app label.color.alpha=0.0 label.width=0
    # echo $WINDOW_TITLE > $WIN_TITLE_FILE
    
    sleep 0.15
    
    sketchybar -m --set front_app label="$WINDOW_TITLE"
    sketchybar --animate sin 5 --set front_app label.color.alpha=1.0 label.width=dynamic
  fi