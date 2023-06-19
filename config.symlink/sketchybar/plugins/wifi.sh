#!/bin/sh

# The wifi_change event supplies a $INFO variable in which the current SSID
# is passed to the script.

WIFI=${INFO:-"N/A"}

sketchybar --set $NAME label="${WIFI}"
