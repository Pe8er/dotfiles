#!/bin/bash

yabai -m query --spaces index --space \
  | jq -re ".index" \
  | xargs -I{} yabai -m query --windows --space {} \
  | jq -sre 'add | map(select(."is-minimized"==false)) | sort_by(.display, .frame.y, .frame.x, .id) | . as $array | length as $array_length | index(map(select(."has-focus"==true))) as $has_index | if $has_index > 0 then nth($has_index - 1).id else nth($array_length - 1).id end' \
  | xargs -I{} yabai -m window --focus {}