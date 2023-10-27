#!/usr/bin/env bash

render_item() {
  sketchybar --set $NAME label="$(date "+%I:%M %p")"
}

render_popup() {
  AGENDA=$(/opt/homebrew/bin/icalBuddy -ec 'Found in Natural Language,CCSF' -npn -nc -iep 'datetime,title' -po 'datetime,title' -eed -ea -n -li 4 -ps '|: |' -b '' eventsToday)
  sketchybar --set clock.details label="$AGENDA" click_script="sketchybar --set $NAME popup.drawing=off" >/dev/null
}

update() {
  render_item
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
esac