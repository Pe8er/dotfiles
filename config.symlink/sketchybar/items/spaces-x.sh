#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

# Defaults
spaces=(
  background.height=2
  # label.padding_right=$PADDINGS
  icon.padding_left=2
  icon.padding_right=2
  label.padding_right=2
  label.font="CaskaydiaCove Nerd Font:Light:12.0"
)
# Register custom event - this will be use by sketchybar's space items as well as app_space.sh
sketchybar --add event window_change

# Space items
# COLORS_SPACE=($YELLOW $CYAN $MAGENTA $WHITE $BLUE $RED $GREEN)
LENGTH=${#ICONS_SPACE[@]}

for i in "${!ICONS_SPACE[@]}"
do
  sid=$(($i+1))
  # PAD_LEFT=2
  # PAD_RIGHT=2
  # if [[ $i == 0 ]]; then
  #   PAD_LEFT=8
  # elif [[ $i == $(($LENGTH-1)) ]]; then
  #   PAD_RIGHT=8
  # fi
  sketchybar --add space space.$sid left                                       \
             --set       space.$sid script="$PLUGIN_DIR/app_space.sh"          \
                                    "${spaces[@]}"                              \
                                    associated_space=$sid                      \
                                    icon=${ICONS_SPACE[i]}                     \
                                    label="_"                                  \
             --subscribe space.$sid front_app_switched window_change mouse.clicked
done
