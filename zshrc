# Machine specific zshrc
test -f ${HOME}/.zshrc.local && source $_

alias dcpm="docker compose -f local.yml run -u dev-user --rm django python manage.py"
alias dcb="docker compose -f local.yml run -u dev-user --rm django bash"
alias dc="docker compose -f local.yml run -u dev-user --rm django"

export PATH="/Applications/PyCharm.app/Contents/MacOS:$PATH"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="avit"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "af-magic" "simple" "apple" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew docker fzf-zsh-plugin fzf-tab)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
  export VISUAL='vim'
else
  export EDITOR='pycharm'
  export VISUAL='pycharm'
#   export EDITOR='code -w'
#   export VISUAL='code -h'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias th=thunter
function open_changed_files () {
  $EDITOR `git diff --name-only ${1:-HEAD~1} | paste -s -d\  -`
}


# # Load Git completion
# zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
# fpath=(~/.zsh $fpath)
# autoload -Uz compinit && compinit

# # Load git prompt
# test -f ${HOME}/.git-prompt.sh && source $_
# setopt PROMPT_SUBST
# PS1='%c$(__git_ps1 " (%s)")\$ '
# GIT_PS1_SHOWDIRTYSTATE=1
# GIT_PS1_SHOWCOLORHINTS=1
# GIT_PS1_SHOWUNTRACKEDFILES=1
alias g=git
alias gs="g s"
alias gd="g d"

git_pr_for_sha() {
    git log --merges --ancestry-path --oneline $1..main | \
        grep 'pull request' | tail -n1 | awk '{print $5}' | cut -c2-
}

autoload -Uz compinit
compinit

# brew loading
eval $(/opt/homebrew/bin/brew shellenv)

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/vault vault


fpath+=~/.zfunc; autoload -Uz compinit; compinit

. "$HOME/.local/bin/env"

# Auto complete for uv
eval "$(uv generate-shell-completion zsh)"


# NVM - node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

export PATH="$HOME/go/bin:$PATH"
export PATH=$HOME/.proto/bin:$HOME/.proto/include:$PATH
eval "$(~/.local/bin/mise activate)"


# >>> conda initialize >>>
# If you'd prefer that conda's base environment not be activated on startup,
#    run the following command when conda is activated:

# conda config --set auto_activate_base false

# Note: You can undo this later by running `conda init --reverse $SHELL`
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/afrias/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/afrias/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/afrias/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/afrias/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
