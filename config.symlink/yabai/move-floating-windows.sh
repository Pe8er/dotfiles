#!/bin/bash

argument=$1

case "$argument" in
"center")
  destination="5:5:1:1:3:3"
  ;;
"lefthalf")
  destination="1:2:0:0:1:1"
  ;;
"righthalf")
  destination="1:2:1:0:1:1"
  ;;
"tophalf")
  destination="2:1:0:0:1:1"
  ;;
"bottomhalf")
  destination="2:1:0:1:1:1"
  ;;
"topleft")
  destination="2:2:0:0:1:1"
  ;;
"bottomleft")
  destination="2:2:0:1:1:1"
  ;;
"topright")
  destination="2:2:1:0:1:1"
  ;;
"bottomright")
  destination="2:2:1:1:1:1"
  ;;
esac

yabai -m window --grid $destination

echo "Window moved to $argument"

