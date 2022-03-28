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

eval $(/opt/homebrew/bin/brew shellenv)

export EDITOR='code -h'
export VISUAL='code -h'