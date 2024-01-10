#!/bin/zsh

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

POPUP_OFF='sketchybar --set logo popup.drawing=off'

sketchybar                                                                               \
  --add item logo left                                                                   \
  --set logo "${menu_defaults[@]}"                                                       \
  icon=􀣺                                                                                \
  icon.font="$FONT:Black:14.0"                                                           \
  label.drawing=off                                                                      \
  popup.align=left                                                                       \
  click_script="sketchybar --set logo popup.drawing=toggle"                              \
  --subscribe logo mouse.exited                                                          \
                   mouse.exited.global                                                   \
\
  --add item logo.about popup.logo                                                       \
  --set logo.about "${menu_item_defaults[@]}"                                            \
  icon=􀅴                                                                                \
  label="About This Mac"                                                                 \
  click_script="open x-apple.systempreferences:com.apple.SystemProfiler.AboutExtension; $POPUP_OFF"  \
  "${separator[@]}"                                                                      \
\
  --add item logo.settings popup.logo                                                    \
  --set logo.settings "${menu_item_defaults[@]}"                                         \
  icon=􀍟                                                                                \
  label="System Settings…"                                                               \
  click_script="open -a 'System Settings'; $POPUP_OFF"                                   \
\
  --add item logo.sleep popup.logo                                                       \
  --set logo.sleep "${menu_item_defaults[@]}"                                            \
  label="Sleep"                                                                          \
  icon=􀜚                                                                                \
  click_script="pmset sleepnow;$POPUP_OFF"                                               \
\
  --add item logo.restart popup.logo                                                     \
  --set logo.restart "${menu_item_defaults[@]}"                                          \
  label="Restart…"                                                                       \
  icon=􀣨                                                                                \
  click_script="osascript -e 'tell app                                                   \"loginwindow\" to «event aevtrrst»'; $POPUP_OFF"  \
\
  --add item logo.shut_down popup.logo                                                   \
  --set logo.shut_down "${menu_item_defaults[@]}"                                        \
  label="Shut Down…"                                                                     \
  icon=􀷃                                                                                \
  click_script="osascript -e 'tell app                                                   \"loginwindow\" to «event aevtrsdn»'; $POPUP_OFF"  \
\
  --add item logo.lock_screen popup.logo                                                 \
  --set logo.lock_screen "${menu_item_defaults[@]}"                                      \
  label="Lock Screen"                                                                    \
  icon=􀼑                                                                                \
  click_script="osascript -e 'tell application                                           \"System Events\" to keystroke                     \"q\" using {command down,control down}'; $POPUP_OFF" \
  --add item logo.logout popup.logo                                                      \
  --set logo.logout "${menu_item_defaults[@]}"                                           \
  label="Log Out ${USER}…"                                                               \
  icon=􀉭                                                                                \
  click_script="osascript -e 'tell app                                                   \"System Events\" to log out'; $POPUP_OFF"         \
  "${separator[@]}"                                                                      \
\
  --add item logo.refresh popup.logo                                                     \
  --set logo.refresh "${menu_item_defaults[@]}"                                          \
  icon=􀅈                                                                                \
  label="Refresh Sketchybar"                                                             \
  click_script="$POPUP_OFF; sketchybar --update"