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
    local trueblack=#000000
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
        trueblack) local color=$trueblack ;;
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
export BAR_COLOR=$(getcolor black 75)
export BAR_BORDER_COLOR=$(getcolor black 50)
export HIGHLIGHT=$(getcolor red)
export HIGHLIGHT_75=$(getcolor red 75)
export HIGHLIGHT_50=$(getcolor red 50)
export HIGHLIGHT_25=$(getcolor red 25)
export HIGHLIGHT_10=$(getcolor red 10)
export ICON_COLOR=$(getcolor white)
export ICON_COLOR_INACTIVE=$(getcolor white 50)
export LABEL_COLOR=$(getcolor white 75)
export POPUP_BACKGROUND_COLOR=$(getcolor black 25)
export POPUP_BORDER_COLOR=$(getcolor black 0)
export SHADOW_COLOR=$(getcolor black)
export TRANSPARENT=$(getcolor black 0)

# # Function to generate a random number within a range
# random_number() {
#     local min=$1
#     local max=$2
#     echo $((RANDOM % (max - min + 1) + min))
# }

# # Function to pick a random color name
# random_color_name() {
#     local colors=("blue" "teal" "cyan" "grey" "green" "yellow" "red" "black" "trueblack" "white")
#     local num_colors=${#colors[@]}
#     local index=$(random_number 0 $((num_colors - 1)))
#     echo ${colors[$index]}
# }

# # Get the current day of the week (1 for Monday, 2 for Tuesday, ..., 7 for Sunday)
# day_of_week=$(date +%u)

# # Pick a random color name
# color_name=$(random_color_name)

# # Set color based on the color name
# color=$(set_color $color_name)