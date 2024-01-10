# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

messages=(
  update_freq=3600
  icon=􀌥
  # label.drawing=off
  script="$PLUGIN_DIR/messages.sh"
)

sketchybar --add item messages right       \
           --set      messages "${messages[@]}"