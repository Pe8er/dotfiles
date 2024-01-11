#!/usr/bin/env bash

# UPLOAD=$(transmission-remote -l | awk 'NR>1 {up=$4} END {print up}')
# DOWNLOAD=$(transmission-remote -l | awk 'NR>1 {up=$5} END {print up}')
TRANSMISSION=$(transmission-remote -l | awk 'NR>1 {up=$4; down=$5} END {print up, down}')

read UP DOWN <<< "$TRANSMISSION"

# Number formatting. Thanks, ChatGPT!
# Your numbers as an array
numbers=($UP $DOWN)

for ((i=0; i<${#numbers[@]}; i++)); do
    current_number=${numbers[i]}

    # Check if the number is greater than 1000
    if (( $(echo "$current_number > 1000" | bc -l) )); then
        formatted_number=$(echo "scale=1; $current_number / 1000" | bc -l)
        suffix="MB"
    else
        formatted_number=$(echo "scale=1; $current_number" | bc -l)
        suffix="KB"
    fi

    # Remove the decimal point if it's zero
    if [[ $formatted_number == *".0" ]]; then
        formatted_number=${formatted_number%"."}
    fi

    # Create a new variable dynamically
    new_variable="formatted_number_$i"
    declare "$new_variable=$formatted_number$suffix"

    # Print the formatted number and the new variable name
    # echo "Original Number: $current_number, Formatted Number: ${!new_variable}"
done

if [[ $TRANSMISSION != "" ]]; then
  sketchybar -m --set $NAME drawing=on label="􀄯${formatted_number_0} 􀄱${formatted_number_1}"
else
  sketchybar -m --set $NAME drawing=off
fi