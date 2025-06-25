# Source stuff
source ~/.config/fish/aliases.fish
source ~/.config/fish/private.fish

# Brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Chruby
chruby ruby-3.3.5 # Set ruby version. Run `chruby` to see actual version.

# Greeting
set -g fish_greeting (set_color yellow)$(weather)\n(set_color FF79C6)$(monty_python_quote)

# Prompt Settings
set -g tide_character_icon →
set -g tide_os_color magenta
set -g fish_color_command yellow
set -g tide_pwd_color_anchors yellow
set -g tide_pwd_color_dirs yellow
set -g tide_pwd_color_truncated_dirs yellow

# Set Paths
fish_add_path /usr/local/sbin
fish_add_path $HOME/.dotfiles/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.config/bin/
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/opt/ruby/bin
fish_add_path $HOME/.dotfiles/config.symlink/yabai/
fish_add_path $BREW_PREFIX/opt/python@3.11/libexec/bin
set -x BREW_PREFIX (brew --prefix)

# iTerm2 Integration
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
