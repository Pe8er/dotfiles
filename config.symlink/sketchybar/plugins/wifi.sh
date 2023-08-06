#!/usr/bin/env bash

render_bar_item() {
  if [ "$SSID" = "" ]; then
    args+=(--set "$NAME" label="N/A")
  else
    args+=(--set "$NAME" label="$SSID (${CURR_TX}Mbps)"
      label.drawing=off) # remove if you want more detailed info available without hovering
  fi

}

render_popup() {
  if [ "$SSID" = "" ]; then
    args+=(--set wifi.details label="N/A"
      click_script="sketchybar --set $NAME popup.drawing=off")
  else
    args+=(--set wifi.details label="$SSID ($CURR_TX Mbps) [$IP_ADDRESS]"
      click_script="sketchybar --set $NAME popup.drawing=off")
  fi

  sketchybar "${args[@]}" >/dev/null

}

update() {
  CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
  IP_ADDRESS="$(ipconfig getifaddr en0)"
  SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"
  CURR_TX="$(echo "$CURRENT_WIFI" | grep -o "lastTxRate: .*" | sed 's/^lastTxRate: //')"

  args=()

  render_bar_item
  render_popup

  if [ "$SENDER" = "forced" ]; then
    sketchybar --animate tanh 15 --set "$NAME" label.y_offset=5 label.y_offset=0
  fi
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
"mouse.clicked")
  popup toggle
  ;;
esac
