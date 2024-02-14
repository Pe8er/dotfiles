sketchybar                                          \
  --add item countdown q                            \
  --set countdown script="$PLUGIN_DIR/countdown.sh" \
  "${bracket_defaults[@]}"                          \
  update_freq=300                                   \
  updates=on                                        \
  icon=􀦛                                            \
  label.font.style="Bold"                           \
  background.color=$(getcolor green)                           \
  background.border_width=1                         \
  background.border_color=$(getcolor grey50)                 \
  label.color=$(getcolor grey)                            \
  icon.color=$(getcolor grey)