#!/bin/bash

# https://github.com/phinze/homebrew-cask/blob/master/USAGE.md

echo "\nInstalling Cask…\n"

if ! brew cask &> /dev/null
  then
    echo "\n...Cask not installed. Installing.\n"
    brew install caskroom/cask/brew-cask
    echo -e "\n...Finished installing Cask.\n"
  else
    echo -e "\nCask already installed.\n"
fi

echo -e "\nPreparing Brew…\n"

brew tap caskroom/versions
brew update
brew doctor

echo -e "\nInstalling apps…\n"

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
brew cask install ubersicht

echo -e "\nInstalling Ubersicht Widgets…\n"

git clone https://github.com/Pe8er/Ubersicht-Widgets.git "/Users/piotrgajos/Library/Application Support/Übersicht/widgets/"

brew cask install xee
brew cask install xld

echo -e "\nCleaning up…\n"

brew cask cleanup
brew cleanup

echo -e "\nDone! Thank you and thank you.\nNow link this folder in Launchbar preferences.\n"

open /opt/homebrew-cask/Caskroom/