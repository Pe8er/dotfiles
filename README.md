# Intro

This is my probably impossibly broken fork of [@holman's dotfiles](https://github.com/holman/dotfiles). Here's some instructions because I never remember what to do:

## 1. iCloud

Hop into System Preferences and ensure everything is turned on.

## 2. Install Dotfiles

1. Install Xcode Developer tools:

    ```bash
    xcode-select --install
    ```

2. Grab the repo and run it:

    ```bash
    git clone https://github.com/Pe8er/dotfiles.git ~/.dotfiles; cd ~/.dotfiles; script/bootstrap`.
    ```

This installs:

1. System and app preferences.
2. Homebrew.
3. Apps.

## 3. Apps Setup

### Mail

1. Enable Junk mail filtering.
2. Enable signatures.
3. Enable rules.

### VSCodium

If I'm not mistaken, it should suffice to install `Settings Sync` extension and use it. Alternatively, a few reminders:

1. Theme: `Tokyo Night` or `Material Ocean High Contrast`
2. Icons: `Fluent Icons`
3. Font: `JetBrainsMono Nerd Font Mono`
4. Allow VSCode to modify itself:

   ```bash
   sudo chown -R $(whoami) $(which codium)
   sudo chown -R $(whoami) /Applications/VSCodium.app/Contents/Resources/app/out
   ```

5. APC Customize UI++ stuff in settings.json:

   ```json
   "workbench.colorTheme": "Tokyo Night",
   "editor.fontFamily": "JetBrainsMono Nerd Font Mono, FiraCode Nerd Font, monospace",
   "editor.fontSize": 13,
   "window.titleBarStyle": "native",
     "apc.electron": {
       "frame": false
     },
     "window.commandCenter": false,
     "workbench.layoutControl.enabled": false,
     "editor.fontLigatures": true,
     "editor.minimap.autohide": true
   ```

6. Enable APC extension.

## Troubleshooting

### Uninstall Homebrew

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
```
