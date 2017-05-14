This is probably impossibly broken fork of [@holman's dotfiles](https://github.com/holman/dotfiles). Here's some instructions because I never know what to do:

# 1. Install Dotfiles

Run `git clone https://github.com/Pe8er/dotfiles.git ~/.dotfiles; cd ~/.dotfiles; script/bootstrap`.

This installs:

1. System and app preferences.
1. Homebrew.
1. Apps.

# 2. Dropbox Sync

Wait for it… especially:

1. 1Password Vault.
2. AppleScripts.
3. Sublime Text `User` folder.
4. App preferences and data (Alfred, The Clock, Candybar etc).

# 3. Replace Home Folders

Run `~/Dropbox/Library/Scripts/Replace Home Folders.scpt`.

# 4. Apps Setup

### 1Password

1. Preferences > Sync > Enable iCloud.
2. Preferences > Advanced > Enable 3rd party integrations.
 
### Alfred

1. Change shortcut.
2. Set theme.
3. Enable clipboard history.
4. Enable 1Password.
 
### Mail

1. Enable signatures.
2. Enable rules.

### The Clock

Restore backup from `~/Dropbox/Apps/The Clock`.

### Sublime Text

##### 1. Activate Material Theme

Cmd + Shift + P > Material Theme: Activate.

##### 2. Enable Material Theme for Markdown
    
1. Preferences > Package Settings > Markdown Editing > Markdown (Standard) Settings - User.
2. Paste `"color_scheme": "Packages/Material Theme/schemes/Material-Theme.tmTheme",`

### Chrome

##### Enable YouTube Dark Theme

1. Open [YouTube](www.youtube.com).
2. Cmd + Shift + I > switch to Console
3. Paste
  `var cookieDate = new Date();
cookieDate.setFullYear(cookieDate.getFullYear( ) + 1);
document.cookie="VISITOR_INFO1_LIVE=fPQ4jCL6EiE; expires=" + cookieDate.toGMTString( ) + "; path=/";`
3. Refresh YouTube.
4. Choose Dark Theme from user menu.

### Misc Crap

1. Confirm iCloud settings.
2. Modify screenshot shortcuts.
3. Sync Hazel rules from Dropbox.

# Troubleshooting

##### Uninstall Homebrew

`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"`