# brew bash complete
test -f ~/.git-completion.bash && . $_
test -f ~/.git-prompt.sh && . $_
test -f /usr/share/bash-completion/bash_completion && . $_
test -f ~/.bash/django_bash_completion.sh && . $_

export YELLOW="$(tput setaf 3)"
export GREEN="$(tput setaf 2)"
export RED="$(tput setaf 1)"
export RESET="$(tput sgr0)"
PS1="\w\$(__git_ps1 \" $YELLOW(%s)$RESET\")\$ "
GIT_PS1_SHOWDIRTYSTATE=1

# Default editor
export EDITOR=/usr/bin/vim

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/PythonProjects
test -f /usr/local/bin/virtualenvwrapper.sh && . $_

# custom commands and aliases
test -f ~/.bash/custom_commands.sh && . $_
test -f ~/.bash/git_aliases.sh && . $_

export HOMEBREW_GITHUB_API_TOKEN="3669a732a6640800e8e48c5aefefe7dc7c955b6d"

# helps with line wrapping issues in tmux
shopt -s checkwinsize

# Vault for counsyl
export VAULT_ADDR=https://vault.counsyl.com

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"


# History settings
# keep duplicates out of history
export HISTCONTROL=ignoreboth:erasedups
# number of lines of history to store in memory
export HISTSIZE=5000
# number of lines of history to store in disk
export HISTFILESIZE=10000
# History file is appended to, so different bash sessions can share history
shopt -s histappend
# immediately updates history so you get history of one bash session
# immediately available in all others
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# turn of CTRL-S for suspend so it can be used for forward search
stty -ixon
