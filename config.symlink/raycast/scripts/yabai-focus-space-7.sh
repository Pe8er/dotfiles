#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Focus Space 7
# @raycast.mode silent

# Optional parameters:
# @raycast.icon assets/7.circle.fill.svg
# @raycast.packageName Yabai

# Documentation:
# @raycast.description Focus Space
# @raycast.author Pior Gajos
# @raycast.authorURL https://github.com/Pe8er

# Get the filename
filename=$(basename "$0")

# Remove the extension '.sh' from the filename
filename_no_extension="${filename%.sh}"

# Get the last character of the filename, which is '1' in this case
spaceNum="${filename_no_extension: -1}"

yabai -m space --focus $spaceNum

