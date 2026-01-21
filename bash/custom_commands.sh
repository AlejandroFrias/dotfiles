#!/bin/bash
alias lsa="ls -Flah"
hash exa 2>/dev/null && alias ls="exa"
hash bat 2>/dev/null && alias cat="bat"

alias diff='git --no-pager diff --color=auto --no-ext-diff --no-index'
alias mlc='find . -name \*.md -exec markdown-link-check {} \;'

function ssht() {
    ssh $* -t 'tmux a || tmux || /bin/bash';
}

# run ctags in background
alias ct="ctags . >/dev/null 2>&1 &"
git_pr_for_sha() {
    git log --merges --ancestry-path --oneline $1..master | \
        grep 'pull request' | tail -n1 | awk '{print $5}' | cut -c2-
}
# return directory containing file, searching parent directories and then subdirectories
function updownsearch() {
    local mdir="$(upsearch "$1")"
    if [[ -z $mdir ]]; then
        mdir="$(find . -name "$1" -exec dirname {} \; -quit)"
    fi
    echo "$mdir"
}

function upsearch() {
    pushd . >/dev/null 2>&1
    local mdir="$(test / == "$PWD" && return || test -e "$1" && echo $(pwd) && return || cd .. && upsearch "$1")"
    popd >/dev/null 2>&1
    echo "$mdir"
}

function maze() {
    local LAST_DIR=$(pwd)
    cd ~/.projects/MazeMaker
    python -c "from maze import *; m = Maze(40, 30); m.redraw()"
    cd $LAST_DIR
}

function repl() {
    local command="${*}"
    echo "Initialized REPL for ${command}"
    local prompt="${command}> "
    IFS= read -er -p "$prompt" input
    while [ "$input" != "" ];
    do
        eval "$command $input"
        IFS= read -er -p "$prompt" input
    done
}

function mk() {
    cd "$(updownsearch Makefile)"
    make "$@"
}