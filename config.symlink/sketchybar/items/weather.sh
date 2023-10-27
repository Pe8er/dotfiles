sketchybar                                                                                               \
  --add item weather right                                                                               \
  --set weather script="$PLUGIN_DIR/weather.sh"                                                          \
  "${menu_defaults[@]}"                                                                                  \
  icon.font="Hack Nerd Font:Bold:14.0"                                                                   \
  icon.padding_right=0                                                                                   \
  popup.align=right                                                                                      \
  update_freq=300                                                                                        \
  updates=on                                                                                             \
  click_script="sketchybar --set weather popup.drawing=toggle; open -a /System/Applications/Weather.app" \
  --subscribe weather wifi_change                                                                        \
                      mouse.entered                                                                      \
                      mouse.exited                                                                       \
                      mouse.exited.global                                                                \
  --add item weather.details popup.weather                                                               \
  --set weather.details "${menu_item_defaults[@]}"