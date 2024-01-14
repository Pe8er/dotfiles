#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"


# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

# sketchybar --set $NAME background.drawing=$SELECTED \
# 	icon.highlight=$SELECTED \
# 	label.highlight=$SELECTED \
#   echo $ICONS_SPACE

  if [ "$SELECTED" = "true" ]; then
    COLOR=$HIGHLIGHT
    OFFSET=-12
  else
    # OFFSET=0
    COLOR=$TRANSPARENT
  fi

  sketchybar --animate tanh 10                     \
             --set $NAME icon.highlight=$SELECTED  \
                         label.highlight=$SELECTED \
                         background.color=$COLOR   \
                         background.y_offset=$OFFSET

create_icons() {

  read -a SPACES <<< "$(yabai -m query --spaces | jq -r '[.[].index] | @tsv')"

  for i in "${!SPACES[@]}"
    do
      sid=$(($i+1))
      LABEL=""
  
      QUERY=$(yabai -m query --windows --space $sid)
      APPS=$(echo $QUERY | jq '.[].app')
      TITLES=$(echo $QUERY | jq '.[].title')
      CURRENT_APP=$(yabai -m query --windows --window | jq -r '.app')
    
      if grep -q "\"" <<< $APPS; then
        APPS_ARR=()
        while read -r line; do APPS_ARR+=("$line"); done <<< "$APPS"
        TITLES_ARR=()
        while read -r line; do TITLES_ARR+=("$line"); done <<< "$TITLES"
    
        LENGTH=${#APPS_ARR[@]}

        for j in "${!APPS_ARR[@]}"
          do
            APP=$(echo ${APPS_ARR[j]} | sed 's/"//g')

            # TITLE=$(echo ${TITLES_ARR[j]} | sed 's/"//g')
            ICON=$($HOME/.config/sketchybar/plugins/app_icon.sh "$APP")

            if [[ "$APP" == "$CURRENT_APP" ]]; then
              SUFFIX=" $APP"
            else
              SUFFIX=""
            fi

            LABEL+="$ICON$SUFFIX"

            if [[ $j < $(($LENGTH-1)) ]]; then
              LABEL+=" "
            fi

          done
      else
        LABEL+="_"
      fi
      sketchybar --set space.$sid label="$LABEL"
    done
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ] || [ "$MODIFIER" = "shift" ]; then
    SPACE_LABEL="$(osascript -e "return (text returned of (display dialog \"Give a name to space $NAME:\" default answer \"\" with icon note buttons {\"Cancel\", \"Continue\"} default button \"Continue\"))")"
    if [ $? -eq 0 ]; then
      if [ "$SPACE_LABEL" = "" ]; then
        set_space_label "${NAME:6}"
      else
        set_space_label "${NAME:6} $SPACE_LABEL"
      fi
    fi
  else
    yabai -m space --focus $SID 2>/dev/null
  fi
}

set_space_label() {
  sketchybar --set $NAME icon="$@"
}

case "$SENDER" in
  "mouse.clicked")
  mouse_clicked
  ;;
  "window_change" | "front_app_switched")
  create_icons
  ;;
esac