#!/usr/bin/env bash

render_item() {
  sketchybar --set $NAME label="$(date "+%I:%M %p")"
}

render_popup() {

  if which "icalBuddy" &>/dev/null; then 
    input=$(/opt/homebrew/bin/icalBuddy -ec 'Found in Natural Language,CCSF' -npn -nc -iep 'datetime,title' -po 'datetime,title' -eed -ea -n -li 4 -ps '|: |' -b '' eventsToday)
    currentTime=$(date '+%I:%M %p')

    # echo "Debug: $NAME #11 $input"

    if [ -n "$input" ]; then
      IFS='^' read -ra events <<< "$input"
      for anEvent in "${events[@]}"; do
        IFS='^' read -ra eventItems <<< "$anEvent"
        eventTime=${eventItems[0]}
        if [ "$eventTime" '>' "$currentTime" ]; then
          theEvent="$anEvent"
          break
        fi
      done
    else
      theEvent="No events today"
    fi
  else
    theEvent="Please install icalBuddy → brew install ical-buddy."
  fi


  sketchybar --set clock.details label="$theEvent" click_script="sketchybar --set $NAME popup.drawing=off" >/dev/null
}

update() {
  render_item
}

popup() {
  render_popup
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