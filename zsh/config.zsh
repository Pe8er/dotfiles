# if [[ -n $SSH_CONNECTION ]]; then
#   export PS1='%m:%3~$(git_info_for_prompt)%# '
# else
#   export PS1='%3~$(git_info_for_prompt)%# '
# fi

# export LSCOLORS="exfxcxdxbxegedabagacad"
export LSCOLORS=ExFxBxDxCxegedabagacad
export CLICOLOR=true

# fpath=($ZSH/functions $fpath)

setopt autocd # Change directories by typing the directory path without using the cd command
setopt NO_BG_NICE # don't nice background tasks
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt PROMPT_SUBST # Enables parameter and command substitution
setopt CORRECT # Enables spelling correction in commands
setopt COMPLETE_IN_WORD # Allows completion to be done within a word
setopt IGNORE_EOF # prevents the shell from exiting when an EOF character (usually Ctrl+D) is entered at the beginning of a line
setopt complete_aliases # allows the shell to expand aliases as part of the completion process.