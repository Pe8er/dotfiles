#!/bin/env/bash

POPUP_OFF="sketchybar --set wifi popup.drawing=off"

sketchybar \
  --add item wifi right \
  --set wifi script="$PLUGIN_DIR/wifi.sh" \
  click_script="$POPUP_CLICK_SCRIPT" \
  updates=when_shown \
  update_freq=5 \
  padding_left=8 \
  popup.align=right \
  "${menu_defaults[@]}" \
  background.color=$CONTRAST          \
  background.border_width=1          \
  background.corner_radius=6         \
  background.height=18               \
  --subscribe wifi wifi_change \
                   mouse.exited \
                   mouse.exited.global \
  --add item wifi.ssid popup.wifi \
  --set wifi.ssid icon=􀅴 \
        label="SSID" \
        "${menu_item_defaults[@]}" \
        click_script="open 'x-apple.systempreferences:com.apple.preference.network?Wi-Fi';$POPUP_OFF" \
  --add item wifi.strength popup.wifi \
  --set wifi.strength icon=􀋨 \
        label="Speed" \
        "${menu_item_defaults[@]}" \
        click_script="open 'x-apple.systempreferences:com.apple.preference.network?Wi-Fi';$POPUP_OFF" \
  --add item wifi.ipaddress popup.wifi \
  --set wifi.ipaddress icon=􀆪 \
        label="IP Address" \
        "${menu_item_defaults[@]}" \
        click_script="echo \"$IP_ADDRESS\"|pbcopy;$POPUP_OFF"