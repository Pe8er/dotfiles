#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

# Defaults
spaces=(
  background.height=2
  icon.padding_left=2
  icon.padding_right=2
  label.padding_right=2
)
# Register custom event - this will be use by sketchybar's space items as well as app_space.sh
sketchybar --add event window_change

# Space items
LENGTH=${#ICONS_SPACE[@]}

for i in "${!ICONS_SPACE[@]}"
do
  sid=$(($i+1))
  sketchybar --add space space.$sid left                                       \
             --set       space.$sid script="$PLUGIN_DIR/app_space.sh"          \
                                    "${spaces[@]}"                              \
                                    associated_space=$sid                      \
                                    icon=${ICONS_SPACE[i]}                     \
                                    label="_"                                  \
             --subscribe space.$sid front_app_switched window_change mouse.clicked
done
