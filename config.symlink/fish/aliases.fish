# Misc abbreviations
abbr \? '~/.dotfiles/bin/cheat-sheet.sh | glow'
abbr jekyll-start 'bundle exec jekyll serve --livereload'
abbr e codium
abbr c codium
abbr code codium
abbr cl clear
abbr cls clear
abbr cp 'cp -v'
abbr dir-sizes 'du -skh */'
abbr dot-pull 'cd ~/.dotfiles; git pl'
abbr md-cheat 'open http://j.mp/144z4kR'
abbr mv 'mv -v'
abbr notify 'terminal-notifier -message'
abbr restart-fish 'source ~/.config/fish/config.fish'
abbr reload-fish 'source ~/.config/fish/config.fish'
abbr rm 'rm -v'
abbr update-hosts 'curl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts > ~/.dotfiles/macos/hosts; sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
abbr update-yabai '~/.config/yabai/update.sh'
abbr ls "eza --color=always --long --git --no-filesize --icons=always --no-permissions --no-user"
abbr lt "eza --color=always --long --git --no-filesize --icons=always --no-permissions --no-user --tree --level=1"
abbr la "eza --classify=auto --color --group-directories-first --sort=extension -a -l --octal-permissions --no-permissions"

abbr update-brew 'brew -v update; brew upgrade --force-bottle; brew cleanup; brew doctor'
abbr where 'which' # sometimes i forget

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