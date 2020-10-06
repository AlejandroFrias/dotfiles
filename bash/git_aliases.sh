########################
# Custom git shortcuts #
########################
alias g='git'
alias gs='git status'
alias gb='git branch'
alias gd='git diff'
alias glog='git glog'
alias gst='git stash'

function gbd () {
    local BRANCH SUCCESS=false
    if [[ $1 == -D ]]; then
        BRANCH="$2"
        git branch -D "$BRANCH" && SUCCESS=true
    else
        BRANCH="$1"
        git branch -d "$BRANCH" && SUCCESS=true
    fi
    if [[ $SUCCESS = true ]]; then
        _hunt_finish "$BRANCH"
    fi
}
function gstlist() {
    git stash list "$@" | awk '{++cnt; $1 = ""; print cnt-1 ":"  $0}'
}
function _convert_stash_number() {
    local re='^[0-9]+$'
    local args=()
    local var
    for var in "$@";
    do
        if [[ $var =~ $re ]]; then
            args+=("stash@{$var}");
        else
            args+=("$var");
        fi;
    done;
    echo "${args[@]}"
}
function _contains_stash_number() {
    local re='^([0-9]+|stash@\{[0-9]+\})$'
    local var
    for var in "$@";
    do
        if [[ $var =~ $re ]]; then
            return 0
        fi
    done
    return 1
}
function _gst_action() {
    local args=("$@")
    _contains_stash_number "${args[@]}"
    if [[ $? == 1 ]]; then
        gstlist
        echo "Select stash number to "$1":"
        local stash_number
        read stash_number
        args+=($stash_number)
    fi
    echo git stash $(_convert_stash_number "${args[@]}")
    git stash $(_convert_stash_number "${args[@]}")
}
function gstshow() {
    _gst_action show "$@"
}
function gstdrop() {
    _gst_action drop "$@"
}
function gstapply() {
    _gst_action apply "$@"
}
function gstpop() {
    _gst_action pop "$@"
}
function gstreverse() {
    local args=("$@")
    _contains_stash_number "${args[@]}"
    if [[ $? == 1 ]]; then
        gstlist
        echo "Select stash number to "$1":"
        local stash_number
        read stash_number
        args+=($stash_number)
    fi
    echo "git stash show -p $(_convert_stash_number "${args[@]}") | patch --reverse"
    git stash show -p $(_convert_stash_number "${args[@]}") | patch --reverse
}
function gpush() {
    local current_branch=$(git rev-parse --abbrev-ref HEAD)
    if [[ $current_branch = "master" ]]; then
        echo "${RED}ERROR${RESET}: Can't push to master."
        return
    fi
    local push_command="git push --set-upstream origin $current_branch"
    echo $push_command
    $push_command
}
