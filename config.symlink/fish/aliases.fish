# Misc abbreviations
abbr \? '~/.dotfiles/bin/cheat_sheet.sh | glow'
abbr bundle 'bundle exec jekyll serve --livereload'
abbr c codium
abbr cl clear
abbr cls clear
abbr cp 'cp -v'
abbr dirsizes 'du -skh */'
abbr dotpull 'cd ~/.dotfiles; git pl'
abbr e nano
# abbr ls lla
abbr mdcheat 'open http://j.mp/144z4kR'
abbr mv 'mv -v'
abbr notify 'terminal-notifier -message'
abbr restart_fish 'source ~/.config/fish/config.fish'
abbr rm 'rm -v'
abbr update_hosts 'curl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts > ~/.dotfiles/macos/hosts; sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
abbr update_yabai '~/.config/yabai/update.sh'
abbr update_znap 'znap pull'
abbr wtf wtfutil

alias update_brew="brew -v update; brew upgrade --force-bottle; brew cleanup; brew doctor"
alias where=which # sometimes i forget

# time to upgrade `ls`. use eza instead of dealing with coreutils, LS_COLORS blah blah
alias ls='eza --classify=auto --color --group-directories-first --sort=extension -A'
alias la='eza --classify=auto --color --group-directories-first --sort=extension -a -l --octal-permissions --no-permissions'

# Navigation
function ..    ; cd .. ; end
function ...   ; cd ../.. ; end
function ....  ; cd ../../.. ; end
function ..... ; cd ../../../.. ; end

# Utilities
function grep     ; command grep --color=auto $argv ; end

# Monty Python????
function monty_python_quote
  set api_url "https://monty-pythons-flying-api.fly.dev/v1/quotes/random"
  set response (curl -s $api_url)
  if test -n "$response"
    echo $response | jq -r '.quote'
  else
    echo "There was a PROBLEM with Monty Python API"
  end
end

function weather
  curl wttr.in/?format=$1 2>/dev/null
end

function a
    echo $argv | amp
end