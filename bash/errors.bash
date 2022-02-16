_date_format="+%d/%b/%Y %H:%M:%S"

function set_date_format () {
    export _date_format="$1"
}

function debug_enable () {
    export _debug='TRUE'
}

function debug_disable () {
    unset _debug
}

function backtrace_enable () {
    export _backtrace='TRUE'
}

function backtrace_disable () {
    unset _backtrace
}

function debug () {
    [ "${_debug:-FALSE}" == FALSE  ] && return

    local _date
    _date="$(command -p date "$_date_format")"
    printf 'DEBUG [%s] <%d> %s\n' "$_date" "$LINENO" "$1"
}

function info () {
    local _date
    _date="$(command -p date "$_date_format")"
    printf "${blue}INFO${reset}  [%s] <%d> %s\n" "$_date" "${BASH_LINENO[*]}" "$1"
}

function warn () {
    local _date
    _date="$(command -p date "$_date_format")"
    printf "${yellow}WARN${reset}  [%s] %s\n" "$_date" "$1"
}

function error () {
    local _date
    _date="$(command -p date "$_date_format")"
    >&2 printf "${red}ERROR${reset} [%s] %s\n" "$_date" "$1"
    [ "${_backtrace:-FALSE}" == FALSE ] || print_backtrace 1
}

function die () {
    local _date
    _date="$(command -p date "$_date_format")"
    >&2 printf "${red}${bold}FATAL${reset} [%s] %s\n" "$_date" "$1"
    print_backtrace 1

    exit "${2:-1}"
}

function print_backtrace () {
    local _date _frame
    _frame="${1:-0}"
    _date="$(command -p date "$_date_format")"
    >&2 printf "${red}${bold}BACKTRACE${reset} [%s] " "$_date"

    local _line _sub _file

    while read -r _line _sub _file < <(caller "$_frame"); do
        >&2 printf '%s@%s:%s <= ' "$_sub" "$_file" "$_line"
        ((_frame++))
    done

    >&2 printf '%s\n' "$SHELL"
}
