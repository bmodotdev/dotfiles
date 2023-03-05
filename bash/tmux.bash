function tmux () {
    case "$1" in
        a)
            shift
            gum_tmux_a
            ;;
        *)
            command -p tmux "$@"
            ;;
    esac
}

function gum_tmux_a () {
    # gum only
    if ! command -v gum >/dev/null 2>&1; then
        error 'Required command “gum” not installed'
        return
    fi

    declare -r _session="$(command -p tmux list-sessions -F \#S | \
        gum filter --placeholder 'Pick session...')"
    [[ "$_session"x == x ]] && return
    command -p tmux switch-client -t $_session \
        || command -p tmux attach -t $_session
}
