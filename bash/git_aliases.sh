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
alias gstall='git stash save --all'
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
        DATABASE="counsyl_product_""$(echo $BRANCH | tr '[:upper:]' '[:lower:]' | tr '[\-]' '[_]')"
        psql -lqt | cut -d \| -f 1 | grep -qw "$DATABASE" && dropdb "$DATABASE"
    fi
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
function _gst_action() {
    if [[ -z $2 ]]; then
        gstlist
        echo "Select stash number to "$1":"
        read stash_number
    else
        stash_number=$2
    fi
    stash_name=$(_get_stash_name $stash_number)
    echo git stash $1 $stash_name
    git stash $1 $stash_name
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
    message=
    if [[ $1 = "-n" ]] || [[ $1 = "-nl" ]] || [[ $1 = "--no-lint" ]]; then
        echo "${YELLOW}Skipping lint...${RESET}"
        message="$2"
    else
        echo "Linting..."
        message="$1"
        if [[ $1 = "-g" ]] || [[ $1 = "-gl" ]] || [[ $1 = "--git-lint" ]]; then
            message="$2"
            make gitlint || SUCCESS=false
        else
            make lint || SUCCESS=false
        fi
        if [[ $SUCCESS = true ]]; then
            echo "${GREEN}Lint successful${RESET}"
        else
            echo "${RED}ERROR${RESET}: Fix lint errors first."
            return
        fi
    fi

    echo git commit -am "$message"
    git commit -am "$message"
}
alias gupdate='git pull origin $(git rev-parse --abbrev-ref HEAD)'
function gpush() {
    force=false
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    push_command="git push origin $current_branch"
    if [[ $1 = "-f" ]] || [[ $1 = "--force" ]]; then
        force=true
    fi
    if [[ $current_branch == 'master' ]] && [[ $force = "false" ]]; then
        echo "${RED}ERROR${RESET}: Can't push to master. Use -f (--force)."
        return
    fi
    echo $push_command
    $push_command
}
