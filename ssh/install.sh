#!/bin/sh

echo "Generating local keys…"
ssh-keygen -t rsa -b 2048

echo "Putting SSH config file where it should be…"
ln -s -f ~/.dotfiles/ssh/config.symlink ~/.ssh/config
rm -r ~/.config

echo "Setting up access without password…"
cat ~/.ssh/id_rsa.pub | ssh pi "cat >> ~/.ssh/authorized_keys"
cat ~/.ssh/id_rsa.pub | ssh spizarnia "cat >> ~/.ssh/authorized_keys"
