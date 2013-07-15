# Pipe my public key to my clipboard. Fuck you, pay me.
alias pubkey="pbcopy < ~/.ssh/id_dsa.pub | echo '=> Public key copied to pasteboard.'"

alias privkey="pbcopy < ~/.ssh/id_rsa.pub | echo '=> Private key copied to pasteboard.'"

