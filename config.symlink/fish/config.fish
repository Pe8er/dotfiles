# Source stuff
source ~/.config/fish/aliases.fish
source ~/.config/fish/private.fish

# Brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Chruby
chruby ruby-3.4.1 # Set ruby version. Run `chruby` to see actual version.

# Greeting
set -g fish_greeting (set_color yellow)$(weather)\n(set_color FF79C6)

# Prompt Settings
set -g tide_character_icon →
set -g tide_os_color magenta
set -g fish_color_command yellow
set -g tide_pwd_color_anchors yellow
set -g tide_pwd_color_dirs yellow
set -g tide_pwd_color_truncated_dirs yellow

# Set Paths
set -x BREW_PREFIX (brew --prefix)
fish_add_path /usr/local/sbin
fish_add_path $HOME/.dotfiles/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.config/bin/
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/opt/ruby/bin
fish_add_path $HOME/.dotfiles/config.symlink/yabai/
fish_add_path $BREW_PREFIX/opt/python@3.11/libexec/bin
fish_add_path $HOME/Library/Python/3.11/bin

# iTerm2 Integration
# test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# Set up fzf key bindings
fzf --fish | source

# Show history-pager on launch
# fzf-history-widget

# Command duration alert
set -g __cmd_start_time 0

function __cmd_timer_start --on-event fish_preexec
    set -g __cmd_start_time (date +%s)
end

function __cmd_timer_end --on-event fish_postexec
    set elapsed (math (date +%s) - $__cmd_start_time)
    if test $elapsed -gt 5
        afplay /System/Library/Sounds/Glass.aiff
    end
end
