alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gch='git checkout'
alias gs='git status'
alias gcommend='git commit --amend --no-edit'
alias ginit='git init && git commit -m “root” --allow-empty'
alias glog='git log --graph --abbrev-commit --decorate --all --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)"'
alias gst='git stash'
alias gstunstaged='git stash --keep-index'
alias gstuntracked='git stash --include-untracked'
alias gstall='git stash --all'
function _get_stash_name() {
    read stash_number
    if [[ ! -z $stash_number ]]; then
        stash_name="stash@{"$stash_number"}"
        echo $stash_name
    fi
}
function gstdrop() {
    git stash list | awk '{++cnt; $1 = ""; print cnt ":"  $0}'
    echo "Select stash number to apply:"
    stash_name=$(_get_stash_name)
    echo git stash apply $stash_name
    git stash drop $stash_name
}
function gstapply() {
    git stash list | awk '{++cnt; $1 = ""; print cnt ":"  $0}'
    echo "Select stash number to apply:"
    stash_name=$(_get_stash_name)
    echo git stash apply $stash_name
    git stash apply $stash_name
}
function gstpop() {
    git stash list | awk '{++cnt; $1 = ""; print cnt ":"  $0}'
    echo "Select stash number to pop:"
    stash_name=$(_get_stash_name)
    echo git stash pop $stash_name
    git stash pop $stash_name
}
function gcam() {
    SUCCESS=true
    message=
    if [[ $1 = "-nl" ]] || [[ $1 = "--no-lint" ]]; then
        echo "Skipping lint..."
        message="$2"
    else
        echo "Linting..."
        message="$1"
        if [[ $PWD = $HOME'/'$TESTV_NFS'/'$WEBSITE_REPO ]]; then
            ssh testv-dev.counsyl.dev 'cd '$NFS_SHARE'/'$WEBSITE_REPO' && make gitlint' || SUCCESS=false
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
function checkout_test_data() {
    echo -n "Are you sure? (y/N) "
    read response
    if [[ $response = "y" ]]; then
        checkout_command=
        checkout_site_media=
        if [[ $1 = -* ]]; then
            checkout_command="git checkout $2 counsyl/product/mynomics/test_data/$(basename ${1:1})"
            if [[ $1 = "-pdf" ]]; then
                checkout_site_media="git checkout $2 counsyl/product/site_media/pdf/"
            fi
        else
            checkout_command="git checkout $1 counsyl/product/mynomics/test_data/"
            checkout_site_media="git checkout $1 counsyl/product/site_media/pdf/"
        fi
        echo $checkout_command
        $checkout_command
        echo $checkout_site_media
        $checkout_site_media
        git status
    fi
}
