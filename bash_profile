test -f $HOME/.bashrc && . $_
test -f $HOME/.bash_profile.local && . $_

complete -C /opt/homebrew/bin/vault vault
. "$HOME/.cargo/env"
