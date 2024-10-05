#!/bin/env/bash

corner_left=(
  background.color=$(getcolor red)
  y_offset=-10
  updates=off                                      
)

sketchybar                                 \
  --add item corner_left left                 \
  --set corner_left "${corner_left[@]}"