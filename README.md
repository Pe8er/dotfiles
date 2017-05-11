This is my humble and impossibly broken fork of [@holman's dotfiles](https://github.com/holman/dotfiles). Here's some instructions because I never know what to do:

# Install Dotfiles

`git clone https://github.com/Pe8er/dotfiles.git ~/.dotfiles; cd ~/.dotfiles; script/bootstrap`

This installs:

1. System and app preferences
1. Homebrew
1. Apps

# Dropbox Sync

Wait for it…especially:

1. 1Password Vault
2. Scripts
2. Sublime User folder
3. Alfred Preferences

# Replace Home Folders

Run `~/Dropbox/Library/Scripts/Replace Home Folders.scpt`

# Apps Setup

### The Clock

Restore backup from Dropbox.

### Mail

1. Enable signatures.
2. Enable rules.

### 1Password

1. Preferences > Sync > Enable iCloud.
2. Preferences > Advanced > Enable 3rd party integrations.

### Alfred

1. Preferences > Advanced > Set Sync Folder.
2. Change shortcut.
2. Set theme.
3. Enable clipboard history.
4. Enable 1Password.

### Sublime Text

##### 1. Install Package Control

`import urllib.request,os,hashlib; h = 'df21e130d211cfc94d9b0905775a7c0f' + '1e3d39e33b79698005270310898eea76'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)`

##### 2. Activate Material Theme

Cmd + Shift + P > Material Theme: Activate

##### 3. Enable Material Theme for Markdown
    
1. Preferences > Package Settings > Markdown Editing > Markdown (Standard) Settings - User.
2. Paste `"color_scheme": "Packages/Material Theme/schemes/Material-Theme.tmTheme",`

### Terminal

1. Preferences > General > Change shell to `/bin/zsh`
2. Preferences > Profiles > Font > `Roboto Mono, 13 pt`

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

### CandyBar

Preferences > select icon library.

### Misc Crap

1. Confirm iCloud settings.
2. Modify screenshot shortcuts.
3. Import Hazel rules.

### Time Machine

1. `cd /Volumes/Time\ Machine`
2. `hdiutil create -size 500g -type SPARSEBUNDLE -fs "HFS+J" Backup-Piotr.sparsebundle`
3. open `Backup-Piotr.sparsebundle.`
4. Name the new volume "Time Machine".
5. `diskutil list`
6. `sudo diskutil enableOwnership /dev/disk2s2`
7. `sudo tmutil setdestination '/Volumes/Time Machine' `

# Troubleshooting

##### Uninstall Homebrew

`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"`

# Todo

2. Fix `gitconfig.local` bullshit.
3. Automate Hazel rules import?
4. Update Finder icon display preferences.
5. Automate all other app settings.