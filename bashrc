# Machine specific bashrc
test -f ${HOME}/.bashrc.local && source $_

# brew bash complete
test -f ~/.git-completion.bash && . $_
test -f ~/.git-prompt.sh && . $_
test -f ~/.bash/completion/bash_completion.sh && . $_


export EDITOR='vim'
export VISUAL='vim'

export YELLOW="$(tput setaf 3)"
export GREEN="$(tput setaf 2)"
export RED="$(tput setaf 1)"
export RESET="$(tput sgr0)"
PROMPT_COMMAND='__git_ps1 "\w" "\\\$ "'
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1

# custom commands and aliases
test -f ~/.bash/custom_commands.sh && . $_
test -f ~/.bash/git_aliases.sh && . $_

# helps with line wrapping issues in tmux
shopt -s checkwinsize

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
# turn off CTRL-S for stopping output to screen so it can be used for forward search
stty -ixon

complete -W "\`grep -oE '^[a-zA-Z0-9_-]+:([^=]|$)' ?akefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make
. "$HOME/.cargo/env"
