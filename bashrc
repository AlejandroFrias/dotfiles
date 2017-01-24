# brew bash complete
test -f ~/.git-completion.bash && . $_
test -f ~/.git-prompt.sh && . $_
PS1="\w\$(__git_ps1 \" $YELLOW(%s)$RESET\")\$ "
GIT_PS1_SHOWDIRTYSTATE=1

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

# helps with line wrapping issues in tmux
shopt -s checkwinsize

# Stop sotring duplicates in bash history
export HISTCONTROL=ignoreboth:erasedups

# Testv nfs settings
export WEBSITE_REPO=website
export YELLOW="$(tput setaf 3)"
export GREEN="$(tput setaf 2)"
export RED="$(tput setaf 1)"
export RESET="$(tput sgr0)"

# Vault for counsyl
export VAULT_ADDR=https://vault.counsyl.com

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
