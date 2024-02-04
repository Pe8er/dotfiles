#!/bin/bash

# https://material-theme.com/docs/reference/color-palette/

# Material Ocean
# "background": "#0F111A",
# "grey": "#3B4252",
# "cyan": "#89ddff",
# "blue": "#82aaff",
# "foreground": "#ffffff",
# "green": "#c3e88d",
# "red": "#ff5370",
# "yellow": "#ffcb6b"

O100=0xff
O75=0xbf
O50=0x80
O25=0x40
O10=0x1a

# Base Colors
export BASE_BLACK="181926" #0F111A
export BASE_WHITE="eeeeee" #eeeeee

# Color Palette
export BLACK="$O100""$BASE_BLACK"
export BLACK_75="$O75""$BASE_BLACK"
export BLACK_50="$O50""$BASE_BLACK"
export BLACK_25="$O25""$BASE_BLACK"
export WHITE="$O100""$BASE_WHITE"
export WHITE_75="$O75""$BASE_WHITE"
export WHITE_50="$O50""$BASE_WHITE"
export WHITE_25="$O25""$BASE_WHITE"
export WHITE_10="$O10""$BASE_WHITE"
export RED=0xffff5370 #ff5370
export GREEN=0xffc3e88d #c3e88d
export TEAL=0xff64FFDA #64FFDA
export CYAN=0xff89ddff #89ddff
export BLUE=0xff82aaff #82aaff
export OSBLUE=0xff0259D1 #0259D1
export YELLOW=0xffffcb6b #ffcb6b
export ORANGE=0xfff78c6c #f78c6c
export MAGENTA=0xffab47bc #ab47bc
export DARK_GREY=0xff292d3e #292d3e
export GREY=0xff676e95 #676e95
export GREY_50=0x80676e95 #676e95
export LIGHT_GREY=0xffa6accd #a6accd
export TRANSPARENT=0x00000000

# General bar colors
export BAR_COLOR=$BLACK_50
export CONTRAST=0xff34324a
export BAR_BORDER_COLOR=0xff2b2a3e
export ICON_COLOR=$WHITE
export ICON_COLOR_INACTIVE=$GREY
export LABEL_COLOR=$WHITE_75
export HIGHLIGHT=$TEAL
export POPUP_BACKGROUND_COLOR=$DARK_GREY
export POPUP_BORDER_COLOR=$TRANSPARENT
export SHADOW_COLOR=$BLACK
