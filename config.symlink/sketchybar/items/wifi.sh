#!/bin/env/bash

POPUP_OFF="sketchybar --set wifi popup.drawing=off"

wifi=(
  "${menu_defaults[@]}"
  script="$PLUGIN_DIR/wifi.sh"
  click_script="$POPUP_CLICK_SCRIPT"
  label.drawing=off
  popup.align=right
  update_freq=5
  --subscribe wifi wifi_change
                   mouse.clicked
                   mouse.exited
                   mouse.exited.global
)

sketchybar                                                                                            \
  --add item wifi right                                                                               \
  --set wifi "${wifi[@]}"                                                                             \
  --add item wifi.ssid popup.wifi                                                                     \
  --set wifi.ssid icon=􀅴                                                                              \
        label="SSID"                                                                                  \
        "${menu_item_defaults[@]}"                                                                    \
        click_script="open 'x-apple.systempreferences:com.apple.preference.network?Wi-Fi';$POPUP_OFF" \
  --add item wifi.strength popup.wifi                                                                 \
  --set wifi.strength icon=􀋨                                                                          \
        label="Speed"                                                                                 \
        "${menu_item_defaults[@]}"                                                                    \
        click_script="open 'x-apple.systempreferences:com.apple.preference.network?Wi-Fi';$POPUP_OFF" \
  --add item wifi.ipaddress popup.wifi                                                                \
  --set wifi.ipaddress icon=􀆪                                                                         \
        label="IP Address"                                                                            \
        "${menu_item_defaults[@]}"                                                                    \
        click_script="echo \"$IP_ADDRESS\"|pbcopy;$POPUP_OFF"