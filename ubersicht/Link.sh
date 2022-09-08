#!/usr/bin/env bash

ORIG_PATH='~/Library/Application\ Support/Übersicht/widgets'

rm -rf $ORIG_PATH
ln -s ~/.dotfiles/ubersicht $ORIG_PATH