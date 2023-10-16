#!/bin/bash

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')
CHARGING_STATUS="Not charging"

source "$CONFIG_DIR/colors.sh"

if [ $PERCENTAGE = "" ]; then
  exit 0
fi

COLOR=$LABEL_COLOR

case ${PERCENTAGE} in
9[0-9] | 100)
  ICON="􀛨"
  ;;
[6-8][0-9])
  ICON="􀺸"
  ;;
[3-5][0-9])
  ICON="􀺶"
  ;;
[1-2][0-9])
  ICON="􀛩"
  COLOR=$ORANGE
  ;;
*) ICON="􀛪" 
   COLOR=$RED
  ;;
esac

if [[ $CHARGING != "" ]]; then
  ICON="􀢋"
  CHARGING_STATUS="Charging"
  COLOR=$LABEL_COLOR
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set $NAME alias.color="${COLOR}"
sketchybar --set $NAME.details label="${CHARGING_STATUS}: $PERCENTAGE%"
