#!/bin/bash

# Load defined icons
source "$CONFIG_DIR/icons.sh"

# Load defined colors
source "$CONFIG_DIR/colors.sh"

PADDINGS=6
FONT="JetBrainsMono Nerd Font"

# Bar Appearance
bar=(
  color=$TRANSPARENT
  position=top
  topmost=off
  sticky=on
  height=32
  padding_left=4
  padding_right=4
  corner_radius=0
  blur_radius=32
  notch_width=170
)

# Item Defaults
item_defaults=(
  background.corner_radius=4
  background.height=20
  background.padding_left=$(($PADDINGS / 2))
  background.padding_right=$(($PADDINGS / 2))
  icon.background.corner_radius=4
  icon.color=$ICON_COLOR
  icon.font="$FONT:Regular:11"
  icon.highlight_color=$HIGHLIGHT
  icon.padding_left=0
  icon.padding_right=0
  label.color=$LABEL_COLOR
  label.font="$FONT:Regular:11"
  label.highlight_color=$HIGHLIGHT
  label.padding_left=$(($PADDINGS / 2))
  scroll_texts=on
  updates=when_shown
)

icon_defaults=(
  label.drawing=off
)

notification_defaults=(
  updates=on
  update_freq=300
  background.padding_left=$PADDINGS
  background.padding_right=$PADDINGS
  drawing=off
)

bracket_defaults=(
  background.corner_radius=6
  background.color=$BAR_COLOR
)

menu_defaults=(
  popup.blur_radius=32
  popup.background.color=$POPUP_BACKGROUND_COLOR
  popup.background.corner_radius=$PADDINGS
  popup.background.shadow.drawing=on
  popup.background.shadow.color=$BAR_COLOR
  popup.background.shadow.angle=90
  popup.background.shadow.distance=64
)

menu_item_defaults=(
  label.font="$FONT:Regular:12"
  padding_left=$PADDINGS
  padding_right=$PADDINGS
  icon.padding_left=0
  icon.padding_right=4
  icon.color=$HIGHLIGHT
  icon.font.size=13
  background.color=$TRANSPARENT
  scroll_texts=off
  icon.width=16
)

separator=(
  background.height=1
  width=180
  background.color="$(getcolor white 25)"
  background.y_offset=-16
)