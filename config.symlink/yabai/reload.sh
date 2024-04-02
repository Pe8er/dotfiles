#!/bin/bash

SID=$(yabai -m query --spaces index --space | jq -r '.index')
source ~/.dotfiles/config.symlink/yabai/yabairc
yabai -m space --focus $SID