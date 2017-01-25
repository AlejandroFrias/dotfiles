#!/bin/bash
alias lsa="ls -Flah"

# run ctags in background
alias ct="ctags . >/dev/null 2>&1 &"

function set_repo() {
    if [[ -z $1 ]]; then
        WEBSITE_REPO=website
    else
        WEBSITE_REPO=$1
    fi
}

# cd to directory containing file, searching subdirectories and then parent directories
function updownsearch() {
    mdir=$(find . -name "$1" -exec dirname {} \;)
    if [[ -z $mdir ]]; then
        pushd . >/dev/null 2>&1
        mdir=$(upsearch "$1")
        popd >/dev/null 2>&1
    fi
    if [[ ! -z $mdir ]]; then
        cd $mdir
    fi
}

function upsearch() {
    test / == "$PWD" && return || test -e "$1" && echo $(pwd) && return || cd .. && upsearch "$1"
}

function cdtv() {
    echo cd ~/vagrant/boxes/testv-dev
    cd ~/vagrant/boxes/testv-dev
}

function cdw() {
    if [[ -z $1 ]]; then
        set_repo
    else
        set_repo "website"-$1
    fi
    cd ~/$WEBSITE_REPO
}

function tvssh() {
    cdtv
    vagrant up
    vagrant ssh
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
function h() {
    if [[ -z $1 ]]; then
        repl hunt
    else
        hunt "$@"
    fi
}

function m() {
    echo source ~/$WEBSITE_REPO/vendor/venv/bin/activate
    source ~/$WEBSITE_REPO/vendor/venv/bin/activate
    echo cd ~/$WEBSITE_REPO/counsyl/product
    cd ~/$WEBSITE_REPO/counsyl/product
    if [[ $1 = "-r" ]]; then
        echo REMOTEDB=1 ./manage.py "${@:2}"
        REMOTEDB=1 ./manage.py "${@:2}"
    else
        echo ./manage.py "$@"
        ./manage.py "$@"
    fi
}

function rs() {
    m $1 runserver 0.0.0.0:8000
}

function mk() {
    echo cd ~/$WEBSITE_REPO
    cd ~/$WEBSITE_REPO
    echo make "$@"
    make "$@"
}

function runtest() {
    if [[ $1 = "-h" ]] || [[ -z $1 ]]; then
        echo ":Usage: runtest [test params] test"
    else
        if [[ $1 == --* ]]; then
            m test "$@"
        else
            m test --retest "$@"
        fi
    fi
}

function runtestlengthy() {
    if [[ $1 = "-h" ]] || [[ -z $1 ]]; then
        echo "Usage: runtestlengthy [test params] test"
    else
        if [[ $1 == --* ]]; then
            m test --run-all "$@"
        else
            m test --run-all --retest "$@"
        fi
    fi
}

function runtestcoverage() {
    if [[ $1 = "-h" ]] || [[ -z $1 ]]; then
        echo "Usage: runtestcoverage test module [html-dir]"
    else
        m test --run-all --retest $1 --cover-package=$2 --cover-html-dir=${3:-~/coverage}
    fi
}

function runtestselenium() {
    if [[ $1 == "-c" ]]; then
        if [[ $2 == --* ]]; then
            m test --run-all ${@:2:$#-2} --settings=counsyl.product.settings_test --only-selenium-tests --with-seleniumnosefilter --selenium-config-preset=remote-chrome --selenium-remote-driver-url=http://10.0.2.2:9515 --selenium-liveserver-external-url=http://testv-dev.counsyl.dev:8081/ --liveserver=0.0.0.0:8081 counsyl.product.${@:$#}
        else
            m test --run-all --retest --with-olfaction --with-progressive --settings=counsyl.product.settings_test --only-selenium-tests --with-seleniumnosefilter --selenium-config-preset=remote-chrome --selenium-remote-driver-url=http://10.0.2.2:9515 --selenium-liveserver-external-url=http://testv-dev.counsyl.dev:8081/ --liveserver=0.0.0.0:8081 counsyl.product.$2
        fi
    elif [[ $1 == --* ]]; then
        m test --run-all ${@:1:$#-1} --settings=counsyl.product.settings_test --with-seleniumnosefilter --only-selenium-tests --selenium-config-preset=local-chrome-xvfb counsyl.product.${@:$#}
    else
        m test --run-all --retest --with-olfaction --with-progressive --settings=counsyl.product.settings_test --with-seleniumnosefilter --only-selenium-tests --selenium-config-preset=local-chrome-xvfb counsyl.product.$1
    fi
}

function runtestseleniumlegacy() {
    if [[ $1 == -* ]]; then
        m test --run-all ${@:2:$#-1} --liveserver=0.0.0.0:8081 --only-legacy-selenium-tests counsyl.product.${@:$#}
    else
        m test --run-all --retest --with-progressive --liveserver=0.0.0.0:8081 --only-legacy-selenium-tests counsyl.product.$1
    fi
}

function tunnel() {
    COMMAND="ssh -NL 3333:127.0.0.1:5432 $1.counsyl.com";
    echo $COMMAND;
    eval $COMMAND;
}
