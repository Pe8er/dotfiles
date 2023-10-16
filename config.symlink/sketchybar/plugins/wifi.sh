#!/bin/bash

POPUP_OFF="sketchybar --set wifi popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set wifi popup.drawing=toggle"

source "$HOME/.config/sketchybar/colors.sh" # Loads all defined colors

IP_ADDRESS=$(scutil --nwi | grep address | sed 's/.*://' | tr -d ' ' | head -1)
IS_VPN=$(/usr/local/bin/piactl get connectionstate)

if [[ $IS_VPN != "Disconnected" ]]; then
  COLOR=$YELLOW
  LABEL_COLOR=$COLOR
  ICON_COLOR=$COLOR
  ICON=􀎡
  LABEL=$IP_ADDRESS
elif [[ $IP_ADDRESS != "" ]]; then
  COLOR=$TRANSPARENT
  ICON=􀙇
  LABEL=$IP_ADDRESS
else
  COLOR=$BLUE
  LABEL_COLOR=$COLOR
  ICON_COLOR=$COLOR
  ICON=􀇿
  LABEL="Disconnected"
fi

render_bar_item() {
sketchybar --set $NAME background.border_color=$COLOR \
  label.color=$LABEL_COLOR \
  icon.color=$ICON_COLOR \
  icon=$ICON \
  label="$LABEL" \
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
  CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
  IP_ADDRESS="$(ipconfig getifaddr en0)"
  SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"
  CURR_TX="$(echo "$CURRENT_WIFI" | grep -o "lastTxRate: .*" | sed 's/^lastTxRate: //')"
  # WIFI_INTERFACE=$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}')

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

  # click_script="sketchybar --set wifi.alias popup.drawing=toggle; $WIFI_CLICK_SCRIPT" \