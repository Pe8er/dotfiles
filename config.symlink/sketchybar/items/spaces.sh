#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

# Defaults
spaces=(
  background.height=16
  background.corner_radius=50
  icon.padding_left=2
  icon.padding_right=2
  label.padding_right=4
)

# # Register custom event - this will be used by sketchybar's space items
sketchybar --add event yabai_window_created_destroyed
#            --add event yabai_window_destroyed \
#            --add event yabai_window_focused   \
#            --add event yabai_application_terminated

# Get all spaces
SPACES=($(yabai -m query --spaces | jq -r '.[].index'))

for SID in "${SPACES[@]}"; do
  sketchybar --add space space.$SID left   \
    --set space.$SID "${spaces[@]}"        \
    script="$PLUGIN_DIR/app_space.sh $SID" \
    associated_space=$SID                  \
    icon=$SID                              \
    --subscribe space.$SID mouse.clicked front_app_switched space_change yabai_window_created_destroyed update_yabai_icon space_windows_change
done

# yabai_window_created yabai_window_destroyed yabai_application_terminated