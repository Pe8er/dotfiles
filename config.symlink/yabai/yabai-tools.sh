#!/bin/bash

# function: show help
help() {
  echo "Usage: yabai-tools.sh [COMMAND]"
  echo ""
  echo "Commands:"
  echo "  help               - Show this help message"
  echo "  start              - Start Yabai service"
  echo "  stop               - Stop Yabai service"
  echo "  restart            - Restart Yabai service"
  echo "  reloadConfig       - Reload Yabai config"
  echo "  status             - Show Yabai service status"
  echo "  updateYabai        - Update Yabai"
  echo "  ——————————————————————————————————————————————"
  echo "  autoArrange        - Automatically arrange windows depending on their count. Use as signals for window create / destroy events"
  echo "  arrange [POSITION] - Move a floating window to [POSITION] on current space"
  echo "  balance            - Balance windows on current space"
  echo "  cycle              - Cycle through windows"
  echo "  float              - Float / unfloat active window"
  echo "  focusSpace [NUM]   - Focus space [NUM]"
  echo "  focusWin [DIR]     - Focus window North | East | South | West"
  echo "  maximize           - Make window full screen or move it back to grid"
  echo "  mirror             - Mirror layout along X or Y axis"
  echo "  move [NUM]         - Move active window to space [NUM]"
  echo "  resize [+|-]       - Increase / decrease active window size"
  echo "  swap               - Swap window positions"
  echo "  toggleSplit        - Toggle horizontal / vertical windows split"
  echo "  toggleLayout       - Toggle stack / bsp layouts"
  echo "  ——————————————————————————————————————————————"
  echo "  [POSITION] options:"
  echo "    lefthalf"
  echo "    righthalf"
  echo "    tophalf"
  echo "    bottomhalf"
  echo "    topleft"
  echo "    bottomleft"
  echo "    topright"
  echo "    bottomright"
  echo "    center"
}

start() {
  echo "Starting yabai..."
  yabai --start-service
}

stop() {
  echo "Stopping yabai..."
  yabai --stop-service
}

restart() {
  echo "Restarting yabai..."
  yabai --restart-service
}

reloadConfig() {
  echo "Reloading yabai config..."
  # sid=$(yabai -m query --spaces index --space | jq -r '.index')
  source ~/.dotfiles/config.symlink/yabai/yabairc
  # yabai -m space --focus $sid
}

status() {
  echo "Checking yabai status..."
  yabai -m query --spaces
}

arrange() {
  case "$1" in
  "lefthalf")
    destination="1:2:0:0:1:1"
    ;;
  "righthalf")
    destination="1:2:1:0:1:1"
    ;;
  "tophalf")
    destination="2:1:0:0:1:1"
    ;;
  "bottomhalf")
    destination="2:1:0:1:1:1"
    ;;
  "topleft")
    destination="2:2:0:0:1:1"
    ;;
  "bottomleft")
    destination="2:2:0:1:1:1"
    ;;
  "topright")
    destination="2:2:1:0:1:1"
    ;;
  "bottomright")
    destination="2:2:1:1:1:1"
    ;;
  "center" | "")
    destination="5:5:1:1:3:3"
    ;;
  esac

  yabai -m window --grid $destination
  updateSketchybar

  echo "Window moved to $1"
}

balance() {
  echo "Balancing windows"
  yabai -m space --balance
}

cycle() {
  echo "Cycling through windows on current space"
  yabai -m query --spaces index --space |
    jq -re ".index" |
    xargs -I{} yabai -m query --windows --space {} |
    jq -sre 'add | map(select(."is-minimized"==false)) | sort_by(.display, .frame.y, .frame.x, .id) | . as $array | length as $array_length | index(map(select(."has-focus"==true))) as $has_index | if $has_index > 0 then nth($has_index - 1).id else nth($array_length - 1).id end' |
    xargs -I{} yabai -m window --focus {}

  updateSketchybar
}

float() {
  windowInfo=$(yabai -m query --windows id,frame,app,is-floating --window)
  appName=$(echo $windowInfo | jq -r '.app')
  isFloating=$(echo $windowInfo | jq -r '."is-floating"')
  positionX=$(printf "%.0f" $(echo $windowInfo | jq -r '.frame.x'))

  echo "$windowInfo" | jq -er '"yabai -m window \(.id) --toggle float --resize top_left:\(.frame.w/40):\(.frame.h/40) --resize bottom_right:\(.frame.w/-40):\(.frame.h/-40)"' |
    sh -

  if [ "$isFloating" = "true" ] && [ "$positionX" -lt 500 ]; then
    yabai -m window --swap prev
  fi

  if [[ "$isFloating" = "false" ]]; then
    echo "Floating $appName"
  else
    echo "Moving $appName back to the grid"
  fi

  updateSketchybar
}

focusSpace() {
  yabai -m space --focus $1

  echo "Welcome to Space $1!"
}

focusWin() {
  yabai -m window --focus $1 > /dev/null
}

maximize() {
  windowInfo=$(yabai -m query --windows app,has-fullscreen-zoom --window)

  yabai -m window --toggle zoom-fullscreen
  updateSketchybar

  appName=$(echo $windowInfo | jq -r '.app')

  isFullScreen=$(echo $windowInfo | jq -r '."has-fullscreen-zoom"')

  if [[ "$isFullScreen" = "false" ]]; then
    echo "Making $appName full screen"
  else
    echo "Moving $appName back to the grid"
  fi
}

mirror() {
  echo "Mirroring windows"
  yabai -m space --mirror x-axis
  yabai -m space --mirror y-axis
}

move() {
  yabai -m window --space "$1" --focus
}

resize() {
  windowResizeAmount=100
  window=$(yabai -m query --windows split-type,split-child --window)
  splitType=$(echo $window | jq -r '."split-type"')
  splitChild=$(echo $window | jq -r '."split-child"')

  if [[ $1 = "+" ]]; then
    symbol="-"
  else
    symbol=
  fi

  if [[ $splitChild == "first_child" ]] && [[ $splitType == "vertical" ]]; then
    direction="right"
  elif [[ $splitChild == "second_child" ]] && [[ $splitType == "vertical" ]]; then
    direction="left"
  elif [[ $splitChild == "first_child" ]] && [[ $splitType == "horizontal" ]]; then
    direction="bottom"
  elif [[ $splitChild == "second_child" ]] && [[ $splitType == "horizontal" ]]; then
    direction="top"
  fi

  if [[ $splitType == "vertical" ]]; then
    resizeCommand="$direction:$symbol$windowResizeAmount:0"
  else
    resizeCommand="$direction:0:$symbol$windowResizeAmount"
  fi

  yabai -m window --resize $resizeCommand
}

swap() {
  echo "Swapping window positions"
  window=$(yabai -m query --windows id --window last | jq '.id')

  while :; do
    yabai -m window $window --swap prev &>/dev/null
    if [[ $? -eq 1 ]]; then
      break
    fi
  done

  updateSketchybar
}

toggleSplit() {
  echo "Toggling horizontal / vertical split"
  yabai -m window --toggle split

  updateSketchybar
}

toggleLayout() {
  echo "Toggling stack and bsp layouts"
  currentLayout=$(yabai -m query --spaces type --space | jq -r .type)
  [[ $currentLayout == "bsp" ]] && setToLayout="stack" || setToLayout="bsp"
  yabai -m space --layout $setToLayout
  echo "Layout changed to $setToLayout"
  updateSketchybar
}

updateYabai() {
  # thanks to gldtn for this script
  # https://github.com/koekeishiya/yabai/discussions/1904#discussion-5730330

  function updatesudoers() {
    echo "updating sudoers.d sha256"
    sha256=$(shasum -a 256 $(which yabai) | awk "{print \$1;}")
    if [ -f "/private/etc/sudoers.d/yabai" ]; then
      sudo sed -i '' -e 's/sha256:[[:alnum:]]*/sha256:'${sha256}'/' /private/etc/sudoers.d/yabai
      echo "sudoers > yabai > sha256 hash update complete"
    else
      echo "sudoers file does not exist yet, or could not be found."
      echo "please create one before running this script."
    fi
  }

  # check & unpin yabai from brew
  if brew list --pinned | grep -q yabai; then
    brew unpin yabai
  fi

  echo "stopping yabai.."
  yabai --stop-service
  brew upgrade yabai

  updatesudoers
  echo "starting yabai..."
  sleep 2
  yabai --start-service

  # pin yabai back to brew
  brew pin yabai
  if brew list --pinned | grep -q yabai; then
    echo "yabai pinned to brew"
  fi

  # success message
  sleep 1
  yabai_v=$(yabai --version)
  echo "your running $yabai_v"
  echo "yabai update completed successfully."

  ################ update from head ################

  # # scripting-addition;
  # # function to update sudoers file
  # function suyabai () {
  #     sha256=$(shasum -a 256 $(which yabai) | awk "{print \$1;}")
  #     if [ -f "/private/etc/sudoers.d/yabai" ]; then
  #         sudo sed -i '' -e 's/sha256:[[:alnum:]]*/sha256:'${sha256}'/' /private/etc/sudoers.d/yabai
  #         echo "sudoers > yabai > sha256 hash update complete"
  #     else
  #         echo "sudoers file does not exist yet. please create one before running this script."
  #     fi
  # }

  # # check & unpin yabai from brew
  # if brew list --pinned | grep -q yabai; then
  #     brew unpin yabai
  # fi

  # # set cert & stop yabai services
  # export yabai_cert=yabai-cert
  # echo "stopping yabai.."
  # yabai --stop-service

  # # reinstall yabai & codesign
  # echo "updating yabai.."
  # brew reinstall koekeishiya/formulae/yabai
  # codesign -fs "${yabai_cert:-yabai-cert}" "$(brew --prefix yabai)/bin/yabai"

  # # update sudoers file & start yabai
  # suyabai
  # echo "starting yabai.."
  # yabai --start-service

  # # pin yabai back to brew
  # brew pin yabai
  # if brew list --pinned | grep -q yabai; then
  #     echo "yabai pinned to brew"
  # fi

  # # success message
  # sleep 1
  # yabai_v=$(yabai --version)
  # echo "your running $yabai_v"
  # echo "yabai update completed successfully."
}

autoArrange() {
  windows=$(yabai -m query --windows --display 1 | jq '[.[] | select(."is-visible"==true and ."is-floating"==false)] | length')

  # if [[ $windows == 0 ]]; then
  #   yabai -m config split_type vertical
  #   yabai -m space --padding abs:128:128:128:128
  #   yabai -m space --balance
  if [[ $windows == 1 || $windows == 2 ]]; then
    # yabai -m config split_type auto
    yabai -m space --padding abs:16:16:16:16
    yabai -m space --balance
  elif [[ $windows > 2 ]]; then
    # yabai -m config split_type auto
    yabai -m space --padding abs:0:0:0:0
  fi
}

updateSketchybar() {
  sketchybar --trigger update_yabai_icon
}

# dispatcher: call the appropriate function
if [[ $# -eq 0 ]]; then
  echo "Error: no command provided."
  echo "————————————————————————————————————————————————"
  help
  exit 1
fi

# check if the argument corresponds to a function
command=$1
if declare -f "$command" >/dev/null; then
  "$command" "${@:2}" # call the function and pass any additional arguments
else
  echo "Error: '$command' is not a valid command."
  echo "————————————————————————————————————————————————"
  help
  exit 1
fi
