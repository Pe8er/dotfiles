#!/bin/bash

if [ "$SENDER" = "space_windows_change" ]; then
  args=(--animate sin 10)

  space="$(echo "$INFO" | jq -r '.space')"
  apps="$(echo "$INFO" | jq -r '.apps | keys[]')"

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app
    do
      icon_strip+=" app.$app"
    done <<< "${apps}"
  else
    icon_strip="—"
  fi
  args+=(--set space.$space icon.background.image="$icon_strip")

  # icon_strip=" "
  # if [ "${apps}" != "" ]; then
  #   while read -r app
  #   do
  #     icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
  #   done <<< "${apps}"
  # else
  #   icon_strip=" —"
  # fi
  # args+=(--set space.$space label="$icon_strip")

  sketchybar -m "${args[@]}"
fi
