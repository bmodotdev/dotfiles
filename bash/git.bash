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
    esac
}

function git_branch_prompt () {
    [[ -e '.git' ]] || return

    local _branch
    _branch="$(command -p git symbolic-ref -q HEAD)"
    _branch="${_branch##refs/heads/}"
    _branch="${_branch:-HEAD}"

    printf '▶ '
    # Clean
    if command -p git status 2>/dev/null | command -p grep -q 'nothing to commit'; then
        printf '%s' "$_branch"
    # Staged
    elif command -p git status 2>/dev/null | command -p grep -q 'Changes to be committed'; then
        printf "${bold}${yellow}%s${reset}" "$_branch"
    # Modified
    else
        printf "${bold}${cyan}%s${reset}" "$_branch"
    fi
}

#########
# Setup #
#########
set_prompt_command 'PS1="\u@\h [ \w $(git_branch_prompt) ] \$ "'
