#!/bin/bash

# Load defined icons
source "$CONFIG_DIR/icons.sh"

# Load defined colors
source "$CONFIG_DIR/colors.sh"

PADDINGS=8
FONT="SF Pro"

# Bar Appearance
bar=(
  color=$TRANSPARENT
  position=top
  topmost=off
  sticky=on
  height=32
  padding_left=$PADDINGS
  padding_right=$PADDINGS
  corner_radius=0
  blur_radius=0
  notch_width=160
)

# Item Defaults
item_defaults=(
  background.color=$TRANSPARENT
  background.padding_left=0
  background.padding_right=0
  background.corner_radius=0
  icon.font="$FONT:Semibold:12"
  icon.color=$ICON_COLOR
  icon.highlight_color=$HIGHLIGHT
  icon.padding_left=$PADDINGS
  icon.padding_right=0
  label.font="$FONT:Regular:12"
  label.color=$LABEL_COLOR
  label.highlight_color=$HIGHLIGHT
  label.padding_left=$PADDINGS
  label.padding_right=$PADDINGS
  updates=when_shown
)

icon_defaults=(
  alias.color=$ICON_COLOR
  label.drawing=off
  padding_left=0
  padding_right=-$PADDINGS
)

bracket_defaults=(
  background.height=24
  background.color=$BAR_COLOR
  blur_radius=32
  background.corner_radius=$PADDINGS
  background.padding_left=$(($PADDINGS * 2))
  background.padding_right=$(($PADDINGS * 2))
)

menu_defaults=(
  popup.blur_radius=32
  popup.background.color=$BAR_COLOR
  popup.background.corner_radius=$PADDINGS
  popup.background.shadow.drawing=on
  popup.background.border_width=1
  popup.background.border_color=$GREY_50
)

menu_item_defaults=(
  label.font="$FONT:Regular:14"
  padding_left=$PADDINGS
  padding_right=$PADDINGS
  icon.padding_left=0
  icon.padding_right=0
  background.color=$TRANSPARENT
)

separator=(
  background.height=1
  width=200
  background.color=$WHITE_25
  background.y_offset=-16
)