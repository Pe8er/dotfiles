#!/usr/bin/env bash

# VPN=$(scutil --nc list | grep Connected | sed -E 's/.*"(.*)".*/\1/')

VPN_STATUS=$(/usr/local/bin/piactl get connectionstate)

if [[ "$VPN_STATUS" == "Connected" ]]; then
  sketchybar --set $NAME icon=􀎡
else
  sketchybar --set $NAME drawing=off
fi