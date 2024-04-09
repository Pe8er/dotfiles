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
  # local trueblack=#000000
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
  local trueblack=#000000
  local white=#cfc9c2

# OK #f7768e	This keyword, HTML elements, Regex group symbol, CSS units, Terminal Red
# OK #ff9e64	Number and Boolean constants, Language support constants
# OK #e0af68	Function parameters, Regex character sets, Terminal Yellow
# OK #9ece6a	Strings, CSS class names
# OK #73daca	Object literal keys, Markdown links, Terminal Green
# OK #b4f9f8	Regex literal strings
#  #2ac3de	Language support functions, CSS HTML elements
# OK #7dcfff	Object properties, Regex quantifiers and flags, Markdown headings, Terminal Cyan, Markdown code, Import/export keywords
#  #7aa2f7	Function names, CSS property names, Terminal Blue
# OK #bb9af7	Control Keywords, Storage Types, Regex symbols and operators, HTML Attributes, Terminal Magenta
#  #c0caf5	Variables, Class names, Terminal White
#  #a9b1d6	Editor Foreground
#  #9aa5ce	Markdown Text, HTML Text
#  #cfc9c2	Parameters inside functions (semantic highlighting only)
#  OK #565f89	Comments
#  #414868	Terminal Black
#  #1a1b26	Editor Background (Night)

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
  local COLORS=("blue" "teal" "cyan" "green" "yellow" "orange" "red" "purple")
  echo ${COLORS[$DAY_OF_WEEK]}
}

# Pick a random color name
RANDOMHIGHLIGHT=$(daily_color)

# Bar and item colors
export BAR_COLOR=$(getcolor black 75)
export BAR_BORDER_COLOR=$(getcolor black 50)
export HIGHLIGHT=$(getcolor $RANDOMHIGHLIGHT)
export HIGHLIGHT_75=$(getcolor $RANDOMHIGHLIGHT 75)
export HIGHLIGHT_50=$(getcolor $RANDOMHIGHLIGHT 50)
export HIGHLIGHT_25=$(getcolor $RANDOMHIGHLIGHT 25)
export HIGHLIGHT_10=$(getcolor $RANDOMHIGHLIGHT 10)
export ICON_COLOR=$(getcolor white)
export ICON_COLOR_INACTIVE=$(getcolor white 50)
export LABEL_COLOR=$(getcolor white 75)
export POPUP_BACKGROUND_COLOR=$(getcolor black 25)
export POPUP_BORDER_COLOR=$(getcolor black 0)
export SHADOW_COLOR=$(getcolor black)
export TRANSPARENT=$(getcolor black 0)
