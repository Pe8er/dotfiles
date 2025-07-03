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