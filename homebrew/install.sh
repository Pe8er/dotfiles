#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "  x You should probably install Homebrew first:"
  echo "    http://brew.sh"
  exit
fi

# Install homebrew packages
brew install grc coreutils spark xmlstarlet terminal-notifier node switchaudio-osx

exit 0
