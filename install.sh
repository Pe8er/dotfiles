#!/bin/sh

# Install Brew
if test ! $(which brew)
then
  echo "\nInstalling Homebrew for you…\n"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  brew update
fi

# Install homebrew packages
echo "\nInstalling some packages…\n"
brew tap homebrew/dupes
sudo mv /usr/bin/nano /usr/bin/nano~
brew install grc coreutils spark git nano node

# Add SSH keys
echo "Do you want to add SSH keys? \c"
read aok

ssh-keygen -t rsa -C "piotr@sourcebits.com"
pbcopy < ~/.ssh/id_rsa.pub
open "https://github.com/settings/ssh"

echo "When you're done, hit any key to continue. \c"
read aok

# Grab Dotfiles repo
echo "\nGrabbing Dotfiles repository…\n"
git clone git@github.com:Pe8er/dotfiles.git ~/.dotfiles

# Run Dotfiles Setup
echo "\nDotfiles setup…\n"
cd ~/.dotfiles/
script/bootstrap

export ZSH=$HOME/.dotfiles

# Install apps
echo "\nInstalling some apps…\n"
$ZSH/homebrew/casks.sh

# Set System Preferences
echo "\nSetting system preferences…\n"
$ZSH/osx/set-defaults.sh

# Setting up Crontab
sudo crontab -u $USER $ZSH/system/Piotr.crontab

# Done!
echo "\nDone!\n"