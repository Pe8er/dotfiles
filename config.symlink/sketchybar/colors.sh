#!/bin/bash

# set -x

# https://material-theme.com/docs/reference/color-palette/

# Material Ocean
# background": "#0F111A",
# "grey": "#3B4252",
# "cyan": "#89ddff",
# "blue": "#82aaff",
# "foreground": "#ffffff",
# "green": "#c3e88d",
# "red": "#ff5370",
# "yellow": "#ffcb6b"

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

    local blue=#82aaff
    local teal=#64ffda
    local cyan=#89ddff
    local grey=#3b4252
    local green=#c3e88d
    local yellow=#ffcb6b
    local red=#ff5370
    local black=#0f111a
    local white=#eeeeee

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
        red) local color=$red ;;
        black) local color=$black ;;
        white) local color=$white ;;
        *) 
            echo "Invalid color name: $color_name" >&2
            return 1
            ;;
    esac

    echo $opacity${color:1}
}

# Test the function
# getcolor white 75


# Bar and item colors
export BAR_COLOR=$(getcolor black 25)
export BAR_BORDER_COLOR=$(getcolor black 50)
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


# O100=0xff
# O75=0xbf
# O50=0x80
# O25=0x40
# O10=0x1a

# # Base Colors
# export BASE_BLACK="0F111A" #0F111A
# export BASE_WHITE="eeeeee" #eeeeee
# export BASE_TEAL="64FFDA"  #64FFDA

# # Color Palette
# export BLACK=$O100$BASE_BLACK
# export BLACK_75=$O75$BASE_BLACK
# export BLACK_50=$O50$BASE_BLACK
# export BLACK_25=$O25$BASE_BLACK
# export BLACK_10=$O10$BASE_BLACK
# export WHITE=$O100$BASE_WHITE
# export WHITE_75=$O75$BASE_WHITE
# export WHITE_50=$O50$BASE_WHITE
# export WHITE_25=$O25$BASE_WHITE
# export WHITE_10=$O10$BASE_WHITE
# export RED=0xffff5370   #ff5370
# export GREEN=0xffc3e88d #c3e88d
# export TEAL_100=$O100$BASE_TEAL
# export TEAL_75=$O75$BASE_TEAL
# export TEAL_50=$O50$BASE_TEAL
# export TEAL_25=$O25$BASE_TEAL
# export TEAL_10=$O10$BASE_TEAL
# export CYAN=0xff89ddff       #89ddff
# export BLUE=0xff82aaff       #82aaff
# export OSBLUE=0xff0259D1     #0259D1
# export YELLOW=0xffffcb6b     #ffcb6b
# export ORANGE=0xfff78c6c     #f78c6c
# export MAGENTA=0xffab47bc    #ab47bc
# export DARK_GREY=0xff292d3e  #292d3e
# export GREY=0xff676e95       #676e95
# export GREY_50=0x80676e95    #676e95
# export LIGHT_GREY=0xffa6accd #a6accd
# export TRANSPARENT=0x00000000