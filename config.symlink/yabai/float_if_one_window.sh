#!/bin/bash

# CURRENT_DISPLAY=$(yabai -m query --windows --window | jq '.display')
# WINDOWS_ARRAY=$(yabai -m query --windows --space $(yabai -m query --spaces --space | jq '.index') --display $CURRENT_DISPLAY | jq -r 'map(select(.["is-minimized"]==false and .["is-floating"]==false))')
# NUMBER_OF_WINDOWS=$(echo $WINDOWS_ARRAY | jq -r 'length')

# case $NUMBER_OF_WINDOWS in
# 	[0-1])
# 		yabai -m config layout float
# 		;;
# 	*)
# 		yabai -m config layout bsp
# 		;;
# 	# *)
# 	# 	yabai -m config layout bsp
# 	# 	;;
# esac

# ~/.config/yabai/three-columns.sh  (Remember to chmod +x the file)

windows=$(yabai -m query --windows --display 1 | jq '[.[] | select(."is-visible"==true and ."is-floating"==false)] | length')

case $windows in
[0-1])
	yabai -m config left_padding 200
	yabai -m config right_padding 200
	yabai -m config top_padding 100
	yabai -m config bottom_padding 100
	;;
*)
	yabai -m config left_padding 8
	yabai -m config right_padding 8
	yabai -m config top_padding 0
	yabai -m config bottom_padding 8
	;;
esac

# if [[ $windows == 1 ]]; then
#   yabai -m config left_padding 400
#   yabai -m config right_padding 400
#   yabai -m space --balance
# elif [[ $windows == 2 ]]; then
#   yabai -m config left_padding 849
#   yabai -m config right_padding 849
#   yabai -m space --balance
# elif [[ $windows == 3 ]]; then
#   yabai -m config left_padding 15
#   yabai -m config right_padding 15
#   yabai -m space --balance
# fi

sketchybar --trigger update_yabai_icon
