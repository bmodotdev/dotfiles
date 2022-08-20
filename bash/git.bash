###########
# Aliases #
###########

#############
# Functions #
#############
function gum_git_checkout () {
    local _branch _selection
    _branch="$1"

    if [[ x"$_branch" == x ]] && command -v gum >/dev/null 2>&1; then
        _selection="$(command -p git branch | command gum filter)"
        command -p git checkout "${_selection##* }"
    else
        command -p git checkout "$@"
    fi
}

function g () {
    case "$1" in
        co|checkout)
            shift
            gum_git_checkout "$@"
            ;;
        *)
            command -p git "$@"
            ;;
    esac
}

function git_branch_prompt () {

    local _branch _status
    _branch="$(command -p git symbolic-ref -q HEAD 2>/dev/null)"
    [[ "${_branch}"x == x ]] && return

    _branch="${_branch##refs/heads/}"
    _branch="${_branch:-HEAD}"
    _status="$(command -p git status 2>/dev/null)"

    printf '▶ '
    # Clean
    if [[ "$_status" =~ 'nothing to commit' ]]; then
        printf '%s' "$_branch"
    # Staged
    elif [[ "$_status" =~ 'Changes to be committed' ]]; then
        printf "${bold}${green}%s${reset} " "$_branch"
    # Modified
    else
        printf "${red}%s${reset} " "$_branch"
    fi
}

#########
# Setup #
#########
set_prompt_command 'PS1="${blue}\u${reset}@${blue}\h${reset} [ \w $(git_branch_prompt)] \$ "'
