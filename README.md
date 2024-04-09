This is my probably impossibly broken fork of [@holman's dotfiles](https://github.com/holman/dotfiles). Here's some instructions because I never remember what to do:

# 1. iCloud

Hop into System Preferences and ensure everything is turned on.

# 2. Install Dotfiles

1.  Install Xcode Developer tools: `xcode-select --install`
2.  Grab the repo and run it: `git clone https://github.com/Pe8er/dotfiles.git ~/.dotfiles; cd ~/.dotfiles; script/bootstrap`.

This installs:

1.  System and app preferences.
2.  Homebrew.
3.  Apps.

# 3. Apps Setup

### Additional Downloads

1. [Things](https://apps.apple.com/us/app/things-3/id904280696)
2. [Silicio](https://apps.apple.com/gb/app/silicio-mini-player/id933627574)
3. Adobe Apps
4. [Popcorn-Time](https://github.com/popcorn-official/popcorn-desktop/)

### Mail

1.  Enable Junk mail filtering.
2.  Enable signatures.
3.  Enable rules.

### Things

1.  Download and run.
2.  Enable Things Cloud.
3.  Check:
    1.  Quick Entry shortcuts (Ctrl + ~ and Ctrl + Esc)
    2.  Calendar events.
    3.  Reminders.

# Troubleshooting

##### Uninstall Homebrew

`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"`
