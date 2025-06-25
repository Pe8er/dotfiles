#!/bin/bash

weather=(
  "${menu_defaults[@]}"
  "${notification_defaults[@]}"
  update_freq=1800
  popup.align=center
  icon.color=$HIGHLIGHT
  script="$PLUGIN_DIR/weather.sh"
  --subscribe weather wifi_change
                      mouse.clicked
                      system_woke
)

aqi=(
  label.color=$LABEL_COLOR_NEGATIVE
  drawing=off
  background.height=16
  label.padding_left=$PADDINGS
  label.padding_right=$PADDINGS
)

sketchybar                                       \
  --add item aqi $1                              \
  --add item weather $1                          \
  --set weather "${weather[@]}"                  \
  --set aqi "${aqi[@]}"                          \
  --add item weather.location popup.weather      \
  --add item weather.condition popup.weather     \
  --add item weather.aqi popup.weather           \
  --add item weather.precipitation popup.weather \
  --add item weather.wind popup.weather          \
  --add item weather.humidity popup.weather      \
  --add item weather.update popup.weather        \
  --add item weather.openapp popup.weather       \
  --set '/weather\..*/' "${menu_item_defaults[@]}" click_script="sketchybar --set weather popup.drawing=off"