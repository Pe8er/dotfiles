#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Desktop Icons
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🙈
# @raycast.packageName Finder

# Documentation:
# @raycast.description Show or hide icons on Desktop and restart Finder
# @raycast.author Pior Gajos
# @raycast.authorURL https://github.com/Pe8er

#!/bin/bash

case $(defaults read com.apple.finder CreateDesktop) in
1)
  NEWSTATE="false"
  ;;
0)
  NEWSTATE="true"
  ;;
esac

defaults write com.apple.finder CreateDesktop -bool $NEWSTATE
killall Finder

