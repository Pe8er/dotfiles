#!/usr/bin/env zsh

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

brew=(
  "${notification_defaults[@]}"
  icon=$ICON_PACKAGE
  script="$PLUGIN_DIR/brew.sh"
  click_script="$PLUGIN_DIR/brew.sh"
  --subscribe brew mouse.clicked
  # click_script="$CONFIG_DIR/items/brew_script.sh"
  # click_script="brew config > /tmp/brew-cfg.log 2>&1 ; brew doctor > /tmp/brew-doctor.log 2>&1"
  # click_script="export HOMEBREW_FORCE_VENDOR_RUBY=1 ; "$brew" config > /tmp/brew-cfg.log 2>&1 ; "$brew" doctor > /tmp/brew-doctor.log 2>&1 ; "$brew" update --debug > /tmp/brew-update.log 2>&1 ; "$brew" upgrade --debug > /tmp/brew-upgrade.log 2>&1"
)

sketchybar --add item  brew right            \
           --set       brew "${brew[@]}"