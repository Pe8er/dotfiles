#!/bin/bash

# set -x

# https://material-theme.com/docs/reference/color-palette/

#!/bin/bash

getcolor() {

  color_name=$1
  opacity=$2

  local o100=0xff
  local o75=0xbf
  local o50=0x80
  local o25=0x40
  local o10=0x1a
  local o0=0x00

  local trueblack=#000000

  # Material Darker
  # local blue=#82aaff
  # local teal=#64ffda
  # local cyan=#89ddff
  # local grey=#3b4252
  # local green=#c3e88d
  # local yellow=#ffcb6b
  # local orange=#f78c6c
  # local red=#ff5370
  # local purple=#c792ea
  # local black=#0f111a
  # local white=#eeeeee

  #Tokyo Night
  local blue=#7dcfff
  local teal=#73daca
  local cyan=#b4f9f8
  local grey=#565f89
  local green=#9ece6a
  local yellow=#e0af68
  local orange=#ff9e64
  local red=#f7768e
  local purple=#bb9af7
  local black=#1a1b26
  local white=#cfc9c2

  case $opacity in
  75) local opacity=$o75 ;;
  50) local opacity=$o50 ;;
  25) local opacity=$o25 ;;
  10) local opacity=$o10 ;;
  0) local opacity=$o0 ;;
  *) local opacity=$o100 ;;
  esac

  case $color_name in
  blue) local color=$blue ;;
  teal) local color=$teal ;;
  cyan) local color=$cyan ;;
  grey) local color=$grey ;;
  green) local color=$green ;;
  yellow) local color=$yellow ;;
  orange) local color=$orange ;;
  red) local color=$red ;;
  purple) local color=$purple ;;
  black) local color=$black ;;
  trueblack) local color=$trueblack ;;
  white) local color=$white ;;
  *)
    echo "Invalid color name: $color_name" >&2
    return 1
    ;;
  esac

  echo $opacity${color:1}
}

# Pick color based on day of week
daily_color() {
  DAY_OF_WEEK=$(date +%u)
  local COLORS=("blue" "teal" "cyan" "green" "yellow" "orange" "red" "purple" "grey")
  echo ${COLORS[$DAY_OF_WEEK]}
}

# Pick a random color name
# RANDOMHIGHLIGHT=$(daily_color)

# Bar and item colors
export BAR_COLOR=$(getcolor trueblack)
export BAR_BORDER_COLOR=$(getcolor black 0)
export HIGHLIGHT=$(getcolor teal)
export HIGHLIGHT_75=$(getcolor teal 75)
export HIGHLIGHT_50=$(getcolor teal 50)
export HIGHLIGHT_25=$(getcolor teal 25)
export HIGHLIGHT_10=$(getcolor teal 10)
export ICON_COLOR=$(getcolor white)
export ICON_COLOR_INACTIVE=$(getcolor white 50)
export LABEL_COLOR=$(getcolor white 75)
export POPUP_BACKGROUND_COLOR=$(getcolor black 25)
export POPUP_BORDER_COLOR=$(getcolor black 0)
export SHADOW_COLOR=$(getcolor black)
export TRANSPARENT=$(getcolor black 0)
