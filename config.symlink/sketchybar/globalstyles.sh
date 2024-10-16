#!/bin/bash

# Load defined icons
source "$CONFIG_DIR/icons.sh"

# Load defined colors
source "$CONFIG_DIR/colors.sh"

PADDINGS=8
FONT="JetBrainsMono Nerd Font"

# Bar Appearance
bar=(
  color=$BAR_COLOR
  position=top
  topmost=off
  sticky=on
  height=32
  padding_left=4
  padding_right=4
  corner_radius=0
  blur_radius=0
  notch_width=170
)

# Item Defaults
item_defaults=(
  background.padding_left=$(($PADDINGS / 2))
  background.padding_right=$(($PADDINGS / 2))
  background.height=20
  icon.padding_left=2
  icon.padding_right=$(($PADDINGS / 2))
  icon.background.corner_radius=4
  icon.font="$FONT:Regular:11"
  icon.color=$ICON_COLOR
  icon.highlight_color=$HIGHLIGHT
  label.font="$FONT:Regular:11"
  label.color=$LABEL_COLOR
  label.highlight_color=$HIGHLIGHT
  label.padding_left=$(($PADDINGS / 2))
  updates=when_shown
  scroll_texts=on
  background.corner_radius=4
)

icon_defaults=(
  label.drawing=off
)

notification_defaults=(
  background.color="$(getcolor white 25)"
  icon.color="$(getcolor black 75)"
  icon.padding_left=4
  icon.padding_right=0
  label.color="$(getcolor black 75)"
  label.padding_right=$PADDINGS
  drawing=off
  update_freq=120
  updates=on
)

bracket_defaults=(
  background.color="$(getcolor black)"
)

menu_defaults=(
  popup.blur_radius=32
  popup.background.color=$POPUP_BACKGROUND_COLOR
  popup.background.corner_radius=$PADDINGS
  popup.background.shadow.drawing=on
  popup.background.shadow.color=$(getcolor black 50)
  popup.background.shadow.angle=90
  popup.background.shadow.distance=16
)

menu_item_defaults=(
  label.font="$FONT:Regular:12"
  padding_left=$PADDINGS
  padding_right=$PADDINGS
  icon.padding_left=0
  icon.color=$HIGHLIGHT
  background.color=$TRANSPARENT
  scroll_texts=on
)

separator=(
  background.height=1
  width=180
  background.color="$(getcolor white 25)"
  background.y_offset=-16
)