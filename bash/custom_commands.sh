#!/bin/bash
alias lsa="ls -Flah"

# rerun ctags in background
alias ct="ctags . >/dev/null 2>&1 &"

function set_repo() {
    if [[ -z $1 ]]; then
        echo "WEBSITE_REPO=website"
        WEBSITE_REPO=website
    else
        echo "WEBSITE_REPO=$1"
        WEBSITE_REPO=$1
    fi
}

function cdtv() {
    echo cd ~/vagrant/boxes/testv-dev
    cd ~/vagrant/boxes/testv-dev
}

function cdcms() {
    echo cd ~/websitecms
    cd ~/websitecms
}

function cdw() {
    set_repo
    echo cd ~/$TESTV_NFS/$WEBSITE_REPO
    cd ~/$TESTV_NFS/$WEBSITE_REPO
    echo "On branch ${GREEN}$(git rev-parse --abbrev-ref HEAD)${RESET}"
}

function cdwcr() {
    set_repo website-create-reports
    echo cd ~/$TESTV_NFS/$WEBSITE_REPO
    cd ~/$TESTV_NFS/$WEBSITE_REPO
    echo "On branch ${GREEN}$(git rev-parse --abbrev-ref HEAD)${RESET}"
}

function tvssh() {
    cdtv
    vagrant up
    vagrant ssh
}

function tvsetup() {
    cp -f ~/.bash/vagrant_bash_commands.sh ~/$TESTV_NFS/vagrant_bash_commands.sh
    cdtv
    vagrant up
    setup_command="echo 'export NFS_SHARE=$NFS_SHARE' > ~/.bashrc"
    setup_command=$setup_command" && echo 'export REPO=website' >> ~/.bashrc"
    setup_command=$setup_command" && echo 'test -f ~/$NFS_SHARE/vagrant_bash_commands.sh && source \$_' >> ~/.bashrc"
    setup_command=$setup_command" && echo 'test -f ~/.bashrc && source \$_' > ~/.bash_profile"
    vagrant ssh -c "$setup_command"
}

function cdriver() {
    echo "chromedriver --port-server 0.0.0.0"
    chromedriver --port-server 0.0.0.0
}

function maze() {
    LAST_DIR=$(pwd)
    cd ~/.projects/MazeMaker
    python -c "from maze import *; m = Maze(40, 30); m.redraw()"
    cd $LAST_DIR
}

function repl() {
    command="${*}"
    echo "Initialized REPL for ${command}"
    prompt="${command}> "
    IFS= read -er -p "$prompt" input
    while [ "$input" != "" ];
    do
        eval "$command $input"
        IFS= read -er -p "$prompt" input
    done
}

alias src=". ~/.bashrc"
alias h="repl hunt"
