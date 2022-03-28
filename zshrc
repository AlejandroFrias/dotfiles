# Machine specific zshrc
test -f ${HOME}/.zshrc.local && source $_

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

# Load git prompt
test -f ${HOME}/.git-prompt.sh && source $_
setopt PROMPT_SUBST
PS1='%c$(__git_ps1 " (%s)")\$ '
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUNTRACKEDFILES=1
alias g=git

eval $(/opt/homebrew/bin/brew shellenv)

export EDITOR='code -h'
export VISUAL='code -h'

# History Settings
export HISTFILE=~/.zsh_history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
stty -ixon # allows C-S for search forward

complete -W "\`grep -oE '^[a-zA-Z0-9_-]+:([^=]|$)' ?akefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make