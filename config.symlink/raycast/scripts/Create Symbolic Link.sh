#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Symbolic Link
# @raycast.mode silent
# @raycast.packageName Finder
#
# Optional parameters:
# @raycast.icon assets/link.badge.plus.svg
#
# Documentation:
# @raycast.description Create a symbolic link from selected item(s) in Finder
# @raycast.author Pior Gajos
# @raycast.authorURL https://github.com/Pe8er

posixPaths=$(
  osascript <<EOF
set posixPaths to {}

tell application "Finder"
  set theSelection to selection
  repeat with anItem in theSelection
    set posixPath to POSIX path of (anItem as text)
    set end of posixPaths to posixPath
  end repeat
end tell

return posixPaths
EOF
)

if [ -z "$posixPaths" ]; then
  echo "Can't get Finder selection"
  exit
fi

IFS=',' read -ra filePaths <<<"$posixPaths"

for i in "${!filePaths[@]}"; do
  filePaths[$i]=$(echo -n "${filePaths[$i]}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
done

for path in "${filePaths[@]}"; do
  file=$(basename "$path")
  folder=$(dirname "$path")
  filename="${file%.*}"

  if [ -d "$path" ]; then
    extension=""
  else
    extension=".${file##*.}"
  fi
  ln -s "$path" "$folder/$filename-symlink$extension"
done
