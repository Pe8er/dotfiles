This is my probably impossibly broken fork of [@holman's dotfiles](https://github.com/holman/dotfiles). Here's some instructions because I never remember what to do:

# 1. iCloud

Hop into System Preferences and ensure everything is turned on.

# 2. Install Dotfiles

1. Install Xcode Developer tools: `xcode-select --install`
1. Grab the repo and run it: `git clone https://github.com/Pe8er/dotfiles.git ~/.dotfiles; cd ~/.dotfiles; script/bootstrap`.

This installs:

1. System and app preferences.
1. Homebrew.
1. Apps.

As soon as Dropbox is installed, launch it and start the sync.

# 3. Apps Setup #1

### Alfred

Launch and activate to enable PowerPack.

### 1Password

1. Preferences > Sync > Enable iCloud.
2. Preferences > Advanced > Enable 3rd party integrations.

### Mail

1. Enable Junk mail filtering.
2. Enable signatures.
3. Enable rules.

### Web Browsers

##### Enable YouTube Dark Theme

1. Open [YouTube](www.youtube.com).
2. Cmd + Alt + J > switch to Console
3. Make sure there is no `VISITOR_INFO1` for www.youtube.com.
3. Paste
    1. Chrome: `var cookieDate = new Date();
cookieDate.setFullYear(cookieDate.getFullYear( ) + 1);
document.cookie="VISITOR_INFO1_LIVE=fPQ4jCL6EiE; expires=" + cookieDate.toGMTString( ) + "; path=/";`
    1. Safari: `document.cookie='VISITOR_INFO1_LIVE=fPQ4jCL6EiE;domain=.youtube.com;path=/;max-age='+100*365*24*60*60+';';`
3. Refresh YouTube.
4. Choose Dark Theme from user menu.

### Fantastical 2

1. [Download from App Store](https://itunes.apple.com/us/app/fantastical-2-calendar-and-reminders/id975937182?mt=12).
2. Sign into [fucking iCloud](https://appleid.apple.com/) and generate the fucking app-specific password.

### Things

1. Download and run.
2. Enable Things Cloud.
3. Check:
    1. Quick Entry shortcuts (Ctrl + ~ and Ctrl + Esc)
    2. Calendar events.
    3. Reminders.

### Reeder

1. [Download from App Store](https://itunes.apple.com/us/app/reeder-3/id880001334?mt=12).
2. Sign into Feedly.
3. Increase article font size to 20.

# 4. Dropbox Sync

Wait for it… especially:

1. AppleScripts.
2. Sublime Text `User` folder.
3. App preferences and data (Alfred, The Clock, Candybar etc).

# 5. Replace Home Folders 📦

Run `osascript ~/Dropbox/Library/Scripts/Replace\ Home\ Folders.scpt`.

# 6. Apps Setup #2
 
### Alfred 📦

1. Change shortcut.
2. Set theme.
3. Enable clipboard history.
4. Enable 1Password.
 
### The Clock 📦

Restore backup from `~/Dropbox/Apps/The Clock`.

### Sublime Text 📦

##### 1. Activate Material Theme

Cmd + Shift + P > Material Theme: Activate.

##### 2. Enable Material Theme for Markdown
    
1. Preferences > Package Settings > Markdown Editing > Markdown (Standard) Settings - User.
2. Paste `"color_scheme": "Packages/Material Theme/schemes/Material-Theme.tmTheme",`

### Misc Crap

2. Modify screenshot shortcuts.
3. Sync Hazel rules from Dropbox.
4. Enable Polish dictionaries.
4. Run `~/.dotfiles/macos/set-defaults.sh` again.

# Troubleshooting

##### Uninstall Homebrew

`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"`