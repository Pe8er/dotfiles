#!/bin/bash

# Script Debugger

SCRIPT_DEBUG=true
#SCRIPT_DEBUG=false

# https://github.com/phinze/homebrew-cask/blob/master/USAGE.md

echo "Installing Cask…"

if ! brew cask &> /dev/null
  then
    if $SCRIPT_DEBUG
      then
        echo "...Cask not installed. Installing."
        brew install caskroom/cask/brew-cask
      else
        brew install caskroom/cask/brew-cask > /dev/null
    fi

    if $SCRIPT_DEBUG; then echo -e "...Finished installing Cask."; fi

  else
    if $SCRIPT_DEBUG; then echo -e "Cask already installed."; fi

fi

echo "Preparing Brew…"

brew tap caskroom/versions
brew update
brew doctor

echo "Installing apps…"

brew cask install calibre
brew cask install github
brew cask install google-chrome
brew cask install google-drive
brew cask install hipchat
brew cask install imageoptim
brew cask install launchbar
brew cask install mailbox
brew cask install moom
brew cask install mplayerx
brew cask install omnigraffle
brew cask install simple-comic
brew cask install sketch-toolbox
brew cask install skype
brew cask install steam
brew cask install sublime-text3
brew cask install spotify
brew cask install skype
brew cask install the-unarchiver
brew cask install transmission
brew cask install transmit
brew cask install xee
brew cask install xld

echo "Cleaning up…"

brew cask cleanup
brew cleanup

echo "Done! Thank you and thank you."