#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Yabai Tools
# @raycast.mode silent

# Optional parameters:
# @raycast.icon assets/yabai.png
# @raycast.argument1 { "type": "dropdown", "placeholder": "Command", "data": [{ "title": "arrange [lefthalf]", "value": "arrange" }, { "title": "balance", "value": "balance" }, { "title": "cycle", "value": "cycle" }, { "title": "float", "value": "float" }, { "title": "focusSpace [NUM]", "value": "focusSpace" }, { "title": "focusWin [DIR]", "value": "focusWin" }, { "title": "help", "value": "help" }, { "title": "maximize", "value": "maximize" }, { "title": "mirror", "value": "mirror" }, { "title": "move [NUM]", "value": "move" }, { "title": "reloadConfig", "value": "reloadConfig" }, { "title": "resize [+|-]", "value": "resize" }, { "title": "restart", "value": "restart" }, { "title": "start", "value": "start" }, { "title": "status", "value": "status" }, { "title": "stop", "value": "stop" }, { "title": "swap", "value": "swap" }, { "title": "toggleLayout", "value": "toggleLayout" }, { "title": "toggleSplit", "value": "toggleSplit" }, { "title": "updateYabai", "value": "updateYabai" } ] }
# @raycast.argument2 { "type": "text", "placeholder": "Argument", "optional": true }
# @raycast.packageName Yabai

# Documentation:
# @raycast.description All Yabai scripts in one
# @raycast.author Pior Gajos
# @raycast.authorURL https://github.com/Pe8er

/Users/pe8er/.dotfiles/config.symlink/yabai/yabai-tools.sh "$1" "$2"