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
function gcam() {
    local SUCCESS=true FORCE=false GITLINT=false NOLINT=false

    # Process options
    local args=`getopt :fgn $*`
    if [ $? != 0 ]
    then
        echo 'Usage: gcam [-fgn] COMMIT_MESSAGE'
        return
    fi

    set -- $args

    local opt
    for opt
    do
        case "$opt" in
            -f)
                FORCE=true ; shift ;;
            -g)
                GITLINT=true ; shift ;;
            -n)
                NOLINT=true ; shift ;;
            --) shift ; break ;;
        esac;
    done

    local message="$@"
    if [[ -z "$message" ]]; then
        echo "${RED}Missing required MESSAGE argument${RESET}"
        return
    fi

    # Prevent unintentional commits to master branch
    local current_branch=$(git rev-parse --abbrev-ref HEAD)
    if [[ $current_branch = master ]] && [[ $FORCE = false ]]; then
        echo "${RED}ERROR${RESET}: Can't commit to master. Use -f (--force)."
        return
    fi

    if [[ $NOLINT = true ]]; then
        echo "${YELLOW}Skipping lint...${RESET}"
    else
        echo "Linting..."
        if [[ $GITLINT = true ]]; then
            mk gitlint-python || SUCCESS=false
        else
            mk lint || SUCCESS=false
        fi
        if [[ $SUCCESS = true ]]; then
            echo "${GREEN}Lint successful${RESET}"
        else
            echo "${RED}ERROR${RESET}: Fix lint errors first."
            return
        fi
    fi

    echo git commit -am \""$message"\"
    git commit -am "$message"
}
function gpush() {
    local force=false
    local current_branch=$(git rev-parse --abbrev-ref HEAD)
    local push_command="git push origin $current_branch"
    if [[ $1 = "-f" ]] || [[ $1 = "--force" ]]; then
        force=true
    fi
    if [[ $current_branch = "master" ]] && [[ $force = "false" ]]; then
        echo "${RED}ERROR${RESET}: Can't push to master. Use -f (--force)."
        return
    fi
    echo $push_command
    $push_command
}
