#!/bin/bash

source "$CONFIG_DIR/colors.sh"

render_item() {

  PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
  CHARGING=$(pmset -g batt | grep 'AC Power')
  CHARGING_STATUS="Not charging"

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
  *)
    ICON="􀛪"
    COLOR=$RED
    ;;
  esac

  if [[ $CHARGING != "" ]]; then
    ICON="􀢋"
    CHARGING_STATUS="Charging"
    COLOR=$LABEL_COLOR
  fi

  sketchybar --set battery icon.color="${COLOR}"

}

render_popup() {
  sketchybar --set battery.details label="${CHARGING_STATUS}: $PERCENTAGE%"
}

update() {
  render_item
  render_popup
}

popup() {
  sketchybar --set "$NAME" popup.drawing="$1"
}

case "$SENDER" in
"routine" | "forced")
  update
  ;;
"mouse.entered")
  popup on
  ;;
"mouse.exited" | "mouse.exited.global")
  popup off
  ;;
esac
