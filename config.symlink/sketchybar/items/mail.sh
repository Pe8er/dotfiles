# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

mail=(
  update_freq=3600
  icon=􀍖
  # label.drawing=off
  script="$PLUGIN_DIR/mail.sh"
)

sketchybar --add item mail right       \
           --set      mail "${mail[@]}"