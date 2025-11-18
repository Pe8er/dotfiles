#!/bin/bash

if [ $# -eq 0 ]; then
  set -- "$HOME"
fi

for TARGET_DIR in "$@"; do
  COUNT=$(sudo find "$TARGET_DIR" -name ".DS_Store" -type f -print -delete | wc -l)
  echo "Deleted $COUNT .DS_Store files in $TARGET_DIR"
done
