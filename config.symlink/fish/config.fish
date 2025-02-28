if status is-interactive
    # Commands to run in interactive sessions can go here
      eval "$(/opt/homebrew/bin/brew shellenv)"
end

set -g fish_greeting

# ABBREVIATIONS
abbr \? '~/.dotfiles/bin/cheat_sheet.sh | glow'
abbr bundle 'bundle exec jekyll serve --livereload'
abbr c codium
abbr cl clear
abbr cls clear
abbr dirsizes 'du -skh */'
abbr dotpull 'cd ~/.dotfiles; git pl'
abbr e nano
abbr ls lla
abbr markdownhelp 'open http://j.mp/144z4kR'
abbr notify 'terminal-notifier -message'
abbr update_brew 'brew update && brew upgrade'
abbr update_hosts 'curl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts > ~/.dotfiles/macos/hosts; sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
abbr update_yabai '~/.config/yabai/update.sh'
abbr update_znap 'znap pull'
abbr wtf wtfutil
abbr restart_fish 'source ~/.config/fish/config.fish'

# PATHS
fish_add_path /usr/local/sbin
fish_add_path $HOME/.dotfiles/bin
fish_add_path $HOME/.local/bin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/opt/ruby/bin
fish_add_path $HOME/.dotfiles/config.symlink/yabai/
set -x BREW_PREFIX (brew --prefix)
fish_add_path $BREW_PREFIX/opt/python@3.11/libexec/bin