#!/bin/bash
function set_repo() {
    if [[ -z $1 ]]; then
        echo "REPO=website"
        REPO=website
    else
        echo "REPO=$1"
        REPO=$1
    fi
}

function cdp() {
    echo cd ~/$NFS_SHARE/$REPO/counsyl/product
    cd ~/$NFS_SHARE/$REPO/counsyl/product
}

function cdw() {
    set_repo website
    echo cd ~/$NFS_SHARE/$REPO
    cd ~/$NFS_SHARE/$REPO
    echo "On branch ${GREEN}$(git rev-parse --abbrev-ref HEAD)${RESET}"
}

function cdwcr() {
    set_repo website-create-reports
    echo cd ~/$NFS_SHARE/$REPO
    cd ~/$NFS_SHARE/$REPO
    echo "On branch ${GREEN}$(git rev-parse --abbrev-ref HEAD)${RESET}"
}

function cdapp() {
    cdp
    echo cd "$@"
    cd "$@"
}

function src() {
    echo source ~/$NFS_SHARE/$REPO/vendor/venv/bin/activate
    source ~/$NFS_SHARE/$REPO/vendor/venv/bin/activate
}

function m() {
    src
    cdp
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
    echo cd ~/$NFS_SHARE/$REPO
    cd ~/$NFS_SHARE/$REPO
    echo make "$@"
    make "$@"
}

function lint() {
    mk lint
}

function gitlint() {
    mk gitlint
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
        m test --run-all --retest $1 --cover-package=$2 --cover-html-dir=${3:-~/nfs-share/coverage}
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

function create_reports() {
    timeit=false
    scenarios=()
    flags=()
    flags+=()
    for arg in "$@"; do
        if [[ $arg == "-t" ]]; then
            timeit=true
        elif [[ $arg == --* ]]; then
            flags+=($arg)
        else
            scenarios+=($arg)
        fi
    done
    if [[ -z $scenarios ]]; then
        cdp
        html_files=mynomics/test_data/report_html/*.html
        for f in $html_files; do
            filename=$(basename ${f%.html})
            scenarios+=($filename)
        done
    fi
    for scenario in ${scenarios[@]}; do
        if [[ $timeit == true ]]; then
            time m my_update_test_report_data ${flags[@]} --scenario $scenario
        else
            m my_update_test_report_data ${flags[@]} --scenario $scenario
        fi
    done
}

function bell() {
    "$@"
    tput bel
}
