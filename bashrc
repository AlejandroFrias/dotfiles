# brew bash complete
test -f $(brew --prefix)/share/zsh/site-functions/git-completion.bash && . $_

# Default editor
export EDITOR=/usr/local/bin/vim

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/PythonProjects
test -f /usr/local/bin/virtualenvwrapper.sh && . $_

# custom commands and aliases
test -f ~/.bash/custom_commands.sh && . $_
test -f ~/.bash/git_aliases.sh && . $_

# git bash complete
test -f ~/.git-completion.bash && . $_

export HOMEBREW_GITHUB_API_TOKEN="3669a732a6640800e8e48c5aefefe7dc7c955b6d"

# Testv nfs settings
export WEBSITE_REPO=website
export TESTV_NFS=testv-nfs-2
export NFS_SHARE=nfs-share-2
export GREEN="$(tput setaf 2)"
export RED="$(tput setaf 1)"
export RESET="$(tput sgr0)"

# Docker env
eval $(docker-machine env)

# Vault for counsyl
export VAULT_ADDR=https://vault.counsyl.com

# Desk settings
alias d.='desk .'

# Hook for desk activation
[ -n "$DESK_ENV" ] && source "$DESK_ENV" || true

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
