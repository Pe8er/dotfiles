# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

messages=(
  "${notification_defaults[@]}"
  icon=􀌤
  background.color=$GREEN
  script="$PLUGIN_DIR/messages.sh"
  click_script="open -a /System/Applications/Messages.app"
)

sketchybar --add item messages right       \
           --set      messages "${messages[@]}"