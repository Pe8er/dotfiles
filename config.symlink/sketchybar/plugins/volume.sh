#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

WIDTH=100

volume_change() {
  case $INFO in
  [7-9][0-9] | 100)
    ICON=$ICON_VOLUME_100
    ;;
  [4-6][0-9])
    ICON=$ICON_VOLUME_66
    ;;
  [2-3][0-9])
    ICON=$ICON_VOLUME_33
    ;;
  [0-1][1-9])
    ICON=$ICON_VOLUME_10
    ;;
  [0-9])
    if [ "$(SwitchAudioSource -t output -c)" == "ADI-2 DAC (56680401)" ]; then
      ICON=$ICON_VOLUME_HEADPHONES
    else
      ICON=$ICON_VOLUME_0
    fi
    ;;
  *) ICON=$ICON_VOLUME_100 ;;
  esac

  DRAWING=$([ "$(cat /tmp/sketchybar_sender)" == "focus_on" ] && echo "off" || echo "on")

  sketchybar --set volume_icon icon=$ICON drawing=$DRAWING
  sketchybar --set $NAME slider.percentage=$INFO --animate tanh 30 --set $NAME slider.width=$WIDTH drawing=$DRAWING
  sleep 2

  # Check whether the volume was changed another time while sleeping
  FINAL_PERCENTAGE=$(sketchybar --query $NAME | jq -r ".slider.percentage")
  if ((FINAL_PERCENTAGE == INFO)); then
    sketchybar --animate tanh 30 --set $NAME slider.width=0
  fi
}

mouse_clicked() {
  osascript -e "set volume output volume $PERCENTAGE"
}

case "$SENDER" in
"volume_change")
  volume_change
  ;;
"mouse.clicked")
  mouse_clicked
  ;;
esac
