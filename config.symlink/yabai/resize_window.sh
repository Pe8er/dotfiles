#!/bin/bash

WINDOW_RESIZE_AMOUNT=100
WINDOW=$(yabai -m query --windows --window)
SPLIT_TYPE=$(echo $WINDOW | jq -r '."split-type"')
SPLIT_CHILD=$(echo $WINDOW | jq -r '."split-child"')

resize() {

  if [[ $SPLIT_CHILD == "first_child" ]] && [[ $SPLIT_TYPE == "vertical" ]]; then
    DIRECTION="right"
  elif [[ $SPLIT_CHILD == "second_child" ]] && [[ $SPLIT_TYPE == "vertical" ]]; then
    DIRECTION="left"
  elif [[ $SPLIT_CHILD == "first_child" ]] && [[ $SPLIT_TYPE == "horizontal" ]]; then
    DIRECTION="bottom"
  elif [[ $SPLIT_CHILD == "second_child" ]] && [[ $SPLIT_TYPE == "horizontal" ]]; then
    DIRECTION="top"
  fi

  if [[ $SPLIT_TYPE == "vertical" ]]; then
    echo "$DIRECTION:$1$WINDOW_RESIZE_AMOUNT:0"
  else
    echo "$DIRECTION:0:$1$WINDOW_RESIZE_AMOUNT"
  fi
}

if [[ $1 = "decrease" ]]; then
  SYMBOL="-"
else
  SYMBOL=
fi

yabai -m window --resize $(resize $SYMBOL)