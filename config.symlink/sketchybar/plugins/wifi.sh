#!/bin/bash

POPUP_OFF="sketchybar --set wifi popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set wifi popup.drawing=toggle"

source "$HOME/.config/sketchybar/colors.sh" # Loads defined colors

IS_VPN=$(/usr/local/bin/piactl get connectionstate)
CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
IP_ADDRESS="$(ipconfig getifaddr en0)"
SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"
CURR_TX="$(echo "$CURRENT_WIFI" | grep -o "lastTxRate: .*" | sed 's/^lastTxRate: //')"

if [[ $IS_VPN != "Disconnected" ]]; then
  ICON_COLOR=$GREEN
  ICON=􀎡
elif [[ $SSID = "Ebrietas" ]]; then
  ICON_COLOR=$WHITE
  ICON=􀉤
elif [[ $SSID != "" ]]; then
  ICON_COLOR=$WHITE
  ICON=􀐿
elif [[ $CURRENT_WIFI = "AirPort: Off" ]]; then
  ICON_COLOR=$RED
  ICON=􀐾
else
  ICON_COLOR=$WHITE_25
  ICON=􀐾
fi

render_bar_item() {
sketchybar --set $NAME \
  icon.color=$ICON_COLOR \
  icon=$ICON \
  click_script="$POPUP_CLICK_SCRIPT"
}

render_popup() {
  if [ "$SSID" != "" ]; then
    args=(
    --set wifi click_script="$POPUP_CLICK_SCRIPT"
    --set wifi.ssid label="$SSID"
    --set wifi.strength label="$CURR_TX Mbps"
    --set wifi.ipaddress label="$IP_ADDRESS"
    click_script="printf $IP_ADDRESS | pbcopy;$POPUP_OFF"
    )
  else
    args=(
    --set wifi click_script="")
  fi

  sketchybar "${args[@]}" >/dev/null
}

update() {
  render_bar_item
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
"mouse.clicked")
  popup toggle
  ;;
esac

  # click_script="sketchybar --set wifi.alias popup.drawing=toggle; $WIFI_CLICK_SCRIPT" \