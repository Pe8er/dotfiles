#! /usr/bin/env zsh

function store_window () {
  echo LEelel
  emulate -L zsh -o err_return -o no_unset -o pipefail
  local restore
  restore="$(yabai -m query --windows --window "${YABAI_WINDOW_ID}" |
    jq -re --arg YABAI_WINDOW_ID "${YABAI_WINDOW_ID}" '
      if .is-floating = "true" then
        .frame | "yabai -m window \($YABAI_WINDOW_ID) --move abs:\(.x):\(.y)\n"
               + "yabai -m window \($YABAI_WINDOW_ID) --resize abs:\(.w):\(.h)"
      else
        empty
      end')"
  if [[ ! -z "${restore}" ]]; then
    echo "${restore}" >"/tmp/yabai-restore/${YABAI_WINDOW_ID}.restore"
    chmod +x "/tmp/yabai-restore/${YABAI_WINDOW_ID}.restore"
  fi
}

() {
  emulate -L zsh -o err_return
  rm -rf /tmp/yabai-restore
  mkdir /tmp/yabai-restore
  # The labels below are generated using `uuidgen` to ensure these signals are
  # never running more than once.
  yabai -m signal --add label='AA1BE1CD-6665-47B5-B5C4-111FBFFF0E1D' \
    event=window_moved action="${functions[store_window]}"
  yabai -m signal --add label='91CC175D-9D33-4D48-9767-0FAF33E63209' \
    event=window_resized action="${functions[store_window]}"
}

# To restore a window, run this command:
  # yabai -m window --toggle float &&
  # /tmp/yabai-restore/$(yabai -m query --windows --window | jq -re '.id').restore 2>/dev/null ||
  # true