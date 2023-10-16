#!/bin/env/bash

sketchybar \
  --add space space_template left \
  --set space_template associated_display=1 \
  label.drawing=off \
  drawing=off \
  updates=on \
  icon.background.color=$GREEN \
  icon.background.height=2 \
  icon.background.y_offset=-13 \
  label.background.color=$GREEN \
  label.background.height=2 \
  label.background.y_offset=-13 \
  script="$PLUGIN_DIR/space.sh" \
  \
  --clone spaces_1.web space_template \
  --set spaces_1.web associated_space=1 \
  icon=􀎬 \
  label=Web \
  drawing=on \
  label.drawing=on \
  click_script="yabai -m space --focus 1" \
  \
  --clone spaces_1.todo space_template \
  --set spaces_1.todo associated_space=2 \
  icon=􀩳 \
  label=Todo \
  drawing=on \
  label.drawing=on \
  click_script="yabai -m space --focus 2" \
  \
  --clone spaces_1.comms space_template \
  --set spaces_1.comms associated_space=3 \
  icon=􀌨 \
  label=Comms \
  drawing=on \
  label.drawing=on \
  click_script="yabai -m space --focus 3" \
  \
  --add event window_focus \
  --add event windows_on_spaces \
  \
  --add item spacer_chevron left \
  --set spacer_chevron label.drawing=off \
  icon=􀆊 \
  icon.padding_left=0 \
  \
  --add item front_app left \
  --set front_app script="$PLUGIN_DIR/front_app.sh" \
  icon.drawing=off \
  label.font="$FONT:Bold:12.0" \
  --subscribe front_app front_app_switched