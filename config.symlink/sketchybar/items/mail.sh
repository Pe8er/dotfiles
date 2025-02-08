#!/bin/bash

mail=(
  "${notification_defaults[@]}"
  icon=$ICON_MAIL
  script="$PLUGIN_DIR/mail.sh"
  click_script="open -a /System/Applications/Mail.app"
)

sketchybar --add item  mail $1           \
           --set       mail "${mail[@]}" \
           --subscribe mail front_app_switched