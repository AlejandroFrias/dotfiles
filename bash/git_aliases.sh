########################
#     Git aliases      #
########################
alias g='git'
git config --global alias.ch checkout
git config --global alias.b branch
git config --global alias.s status
git config --global alias.st stash
git config --global alias.st stash
git config --global alias.d diff
git config --global alias.a add
git config --global alias.co commit
git config --global alias.f fetch
git config --global alias.p pull


########################
# Custom git shortcuts #
########################
alias gup='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gs='git status'
alias gd='git diff'
alias gb='git branch'
alias gpom='git pull origin master'
alias gcommend='git commit --amend --no-edit'
alias ginit='git init && git commit -m “root” --allow-empty'
alias glog='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)"'
alias gst='git stash'
alias gstsave='git stash save'
alias gstunstaged='git stash save --keep-index'
alias gstuntracked='git stash save --include-untracked'
alias gstsnapshot='git stash save "[snapshot] $(date)" && git stash apply'

function gbd () {
    SUCCESS=false
    if [[ $1 == -D ]]; then
        BRANCH="$2"
        git branch -D "$BRANCH" && SUCCESS=true
    else
        BRANCH="$1"
        git branch -d "$BRANCH" && SUCCESS=true
    fi
    if [[ $SUCCESS = true ]]; then
        _hunt_finish "$BRANCH"
        if $(hash psql 2>/dev/null) && $(hash dropdb 2>/dev/null); then
            DATABASE="counsyl_product_""$(echo $BRANCH | tr '[:upper:]-' '[:lower:]_')"
            TEST_DATABASE="test_"$DATABASE
            psql -lqt 2>/dev/null | cut -d \| -f 1 | grep -qw "$DATABASE" && echo dropdb "$DATABASE" && dropdb "$DATABASE"
            psql -lqt 2>/dev/null | cut -d \| -f 1 | grep -qw "$TEST_DATABASE" && echo dropdb "$TEST_DATABASE" && dropdb "$TEST_DATABASE"
        fi
    fi
}
# remove merged branches
function gbdm () {
    git branch --merged | grep -v "*" | xargs --no-run-if-empty -n 1 | gbd
}
function gchb () {
    git checkout -b "$1" && _hunt_workon_or_create "$1"
}
function gch () {
    git checkout "$1" && _hunt_workon_or_create "$1"
}
function gchm () {
    git checkout master && _hunt_stop
}
function _hunt_finish () {
    if hash hunt 2>/dev/null; then
        hunt finish "$1" 2>/dev/null
    fi
}
function _hunt_stop () {
    if hash hunt 2>/dev/null; then
        hunt stop &>/dev/null
    fi
}
function _hunt_estimate () {
    if hash hunt 2>/dev/null; then
        read -er -p "Estimate '${1}' (hrs): " estimate
        if [[ ! -z $estimate ]]; then
            hunt estimate $estimate -t "$1" 1>/dev/null
        fi
    fi
}
function _hunt_create() {
    if hash hunt 2>/dev/null; then
        hunt create "$1" 1>/dev/null
        _hunt_estimate "$1"
    fi
}
function _hunt_workon_or_create() {
    if hash hunt 2>/dev/null; then
        hunt workon "$1" &>/dev/null
        if [ "$?" == 2 ]; then
            _hunt_create "$1"
            hunt workon "$1" 1>/dev/null
        fi
    fi
}
function gstlist() {
    git stash list "$@" | awk '{++cnt; $1 = ""; print cnt-1 ":"  $0}'
}
function _get_stash_name() {
    if [[ ! -z $1 ]]; then
        stash_name="stash@{"$1"}"
        echo $stash_name
    fi
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
    SUCCESS=true
    FORCE=false
    GITLINT=false
    NOLINT=false

    # Process options
    args=`getopt :fgn $*`
    if [ $? != 0 ]
    then
        echo 'Usage: gcam [-fgn] COMMIT_MESSAGE'
        return
    fi

    set -- $args

    for i
    do
        case "$i" in
            -f)
                FORCE=true ; shift ;;
            -g)
                GITLINT=true ; shift ;;
            -n)
                NOLINT=true ; shift ;;
            --) shift ; break ;;
        esac;
    done

    message="$@"
    if [[ -z "$message" ]]; then
        echo "${RED}Missing required MESSAGE argument${RESET}"
        return
    fi

    Prevent unintentional commits to master branch
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    if [[ $current_branch = master ]] && [[ $FORCE = false ]]; then
        echo "${RED}ERROR${RESET}: Can't commit to master. Use -f (--force)."
        return
    fi

    if [[ $NOLINT = true ]]; then
        echo "${YELLOW}Skipping lint...${RESET}"
    else
        echo "Linting..."
        if [[ $GITLINT = true ]]; then
            mk gitlint || SUCCESS=false
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
    force=false
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    push_command="git push origin $current_branch"
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
