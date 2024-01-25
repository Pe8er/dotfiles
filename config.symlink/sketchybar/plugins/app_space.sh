#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

if [ "$SELECTED" = "true" ]; then
  COLOR=$HIGHLIGHT
  OFFSET=-12
else
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
      APPS=$(echo $QUERY | jq '.[].app' | uniq)
      CURRENT_APP=$(yabai -m query --windows --window | jq -r '.app')
    
      if grep -q "\"" <<< $APPS; then
        APPS_ARR=()
        while read -r line; do
        APPS_ARR+=("$line"); done <<< "$APPS"
        LENGTH=${#APPS_ARR[@]}

        for j in "${!APPS_ARR[@]}"
          do
            APP=$(echo ${APPS_ARR[j]} | sed 's/"//g')

            ICON=$($HOME/.config/sketchybar/plugins/app_icon.sh "$APP")

            # Define how currently focused app should be highlighted
            if [[ "$APP" == "$CURRENT_APP" ]]; then
              SUFFIX=" $APP"
            else
              SUFFIX=""
            fi

            BADGE=""

            if [[ "$APP" == "Messages" ]]; then
              BADGE=$(sqlite3 ~/Library/Messages/chat.db "SELECT text FROM message WHERE is_read=0 AND is_from_me=0 AND text!='' AND date_read=0" | wc -l | awk '{$1=$1};1')
            else
              BADGE=$(lsappinfo -all info -only StatusLabel "$APP" | sed -nr 's/\"StatusLabel\"=\{ \"label\"=\"(.+)\" \}$/\1/p' )
            fi

            # Define how notifications should be shown.
            if [[ "$BADGE" != "" ]]; then
              # If you want number of notifications instead of dot:
              # SUFFIX+=" ($BADGE)"
              SUFFIX+=" •"
            fi
            
            LABEL+="$ICON$SUFFIX"

            if [[ $j < $(($LENGTH-1)) ]]; then
              LABEL+=" "
            fi

          done
      else
        LABEL+=""
      fi
      sketchybar --set space.$sid label="$LABEL"
    done
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ] || [ "$MODIFIER" = "shift" ]; then
    SPACE_NAME="${NAME#*.}"
    SPACE_LABEL="$(osascript -e "return (text returned of (display dialog \"Rename space $SPACE_NAME to:\" default answer \"\" with title \"Space Renamer\" buttons {\"Cancel\", \"Rename\"} default button \"Rename\"))")"
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