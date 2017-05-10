This is my humble and impossibly broken fork of [@holman's dotfiles](https://github.com/holman/dotfiles). Here's some instructions because I never know what to do:

# Install Dotfiles

- [ ] `git clone https://github.com/Pe8er/dotfiles.git ~/.dotfiles; cd ~/.dotfiles; script/bootstrap`

This installs:

1. System and app preferences
1. Homebrew
1. Apps

# Misc Crap

- [ ] Confirm iCloud settings

# Dropbox Sync

Wait for it…especially:

1. 1Password Vault
2. Scripts
2. Sublime User folder
3. Alfred Preferences

# Replace Home Folders

- [ ] Run `~/Dropbox/Library/Scripts/Replace Home Folders.scpt`

# Apps Setup

### Mail

- [ ] Enable signatures
- [ ] Enable rules
- [ ] Preferences > Viewing > Show most recent message at the top

### 1Password

- [ ] Preferences > Sync > Enable iCloud

### Alfred

- [ ] Preferences > Advanced > Set Sync Folder

### Sublime Text

#### Install Package Control

- [ ] `import urllib.request,os,hashlib; h = 'df21e130d211cfc94d9b0905775a7c0f' + '1e3d39e33b79698005270310898eea76'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)`

#### Activate Material Theme

- [ ] Cmd + Shift + P > Material Theme: Activate

#### Enable Material Theme for Markdown
    
- [ ] Preferences > Package Settings > Markdown Editing > Markdown (Standard) Settings - User.
- [ ] Paste `"color_scheme": "Packages/Material Theme/schemes/Material-Theme.tmTheme",`

### Terminal

- [ ] Preferences > General > Change shell to `/bin/zsh`
- [ ] Preferences > Profiles > Font > `Roboto Mono, 13 pt`

### Chrome

- [ ] Enable YouTube Dark Theme

    1. Open [YouTube](www.youtube.com).
    2. Cmd + Shift + I > switch to Console
    3. Paste
      `var cookieDate = new Date();
    cookieDate.setFullYear(cookieDate.getFullYear( ) + 1);
    document.cookie="VISITOR_INFO1_LIVE=fPQ4jCL6EiE; expires=" + cookieDate.toGMTString( ) + "; path=/";`
    3. Refresh YouTube.
    4. Choose Dark Theme from user menu.

# Troubleshooting

##### Uninstall Homebrew

`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"`

# Todo

1. Improve `Replace Home Folders` script. It needs to create new folders for Sublime, Sketch etc. if they don't exist.
2. Fix `gitconfig.local` bullshit.