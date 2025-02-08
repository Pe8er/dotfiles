#!/bin/bash

reminders=(
  "${notification_defaults[@]}"
  icon=$ICON_TODO
  script="$PLUGIN_DIR/reminders.sh"
  click_script="open -a /System/Applications/Reminders.app"
)

sketchybar --add item  reminders $1                \
           --set       reminders "${reminders[@]}" \
           --subscribe reminders front_app_switched