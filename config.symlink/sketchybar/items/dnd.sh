#!/bin/env/bash

sketchybar                                                    \
  --add item dnd right                                        \
  --set dnd script="$PLUGIN_DIR/dnd.sh"                       \
  label.drawing=off                                           \
  --add event focus_on "_NSDoNotDisturbEnabledNotification"   \
	--add event focus_off "_NSDoNotDisturbDisabledNotification" \
  --subscribe dnd focus_on focus_off mouse.clicked