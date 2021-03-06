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

As soon as Dropbox is installed, launch it and start the sync.

# 3. Apps Setup #1

### Alfred

Launch and activate to enable PowerPack.

### 1Password

1.  Preferences > Sync > Enable iCloud.
2.  Preferences > Advanced > Enable 3rd party integrations.

### Mail

1.  Enable Junk mail filtering.
2.  Enable signatures.
3.  Enable rules.

### Fantastical 2

1.  [Download from App Store](https://itunes.apple.com/us/app/fantastical-2-calendar-and-reminders/id975937182?mt=12).
2.  Sign into [fucking iCloud](https://appleid.apple.com/) and generate the fucking app-specific password.

### Things

1.  Download and run.
2.  Enable Things Cloud.
3.  Check:
    1.  Quick Entry shortcuts (Ctrl + ~ and Ctrl + Esc)
    2.  Calendar events.
    3.  Reminders.

### Reeder

1.  [Download from App Store](https://itunes.apple.com/us/app/reeder-3/id880001334?mt=12).
2.  Sign into Feedly.
3.  Increase article font size to 20.

# 4. Dropbox Sync

Wait for it… especially:

1.  AppleScripts.
2.  App preferences and data (Alfred, The Clock etc).

# 5. Replace Home Folders 📦

Run `osascript ~/Dropbox/Library/Scripts/Tools/Replace\ Home\ Folders.scpt`.

# 6. Apps Setup #2

### Alfred 📦

1.  Change shortcut to `⌥ + Tab`.
2.  Set theme.
3.  Enable clipboard history.
4.  Enable 1Password.

### The Clock 📦

Restore backup from iCloud.

### Misc Crap

4.  Run `~/.dotfiles/script/bootstrap` again.
5.  Run `~/.dotfiles/macos/set-defaults.sh`.
6.  Modify screenshot shortcuts.
7.  Sync Hazel rules from Dropbox.
8.  Enable Polish dictionaries in Dictionary.app.
9.  Run `~/.dotfiles/macos/set-defaults.sh` again.

# Troubleshooting

##### Uninstall Homebrew

`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"`
