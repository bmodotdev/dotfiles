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

# success "Finished install"
#   $1  required    The string to log
#
function success () {
    local _date

    _date="$(command -p date "$_date_format")"

    printf "${green}SUCCESS${reset} [%s] %s\n" "$_date" "${1:-Success}"
}

# debug "Using download mirror: $mirror"
#   $1  required    The string to log
#
function debug () {
    [ "${_debug:-FALSE}" == FALSE  ] && return

    local _date

    _date="$(command -p date "$_date_format")"
    read -r _line _sub _file < <(caller 0)

    printf 'DEBUG   [%s] <%s@%s:%s> %s\n' "$_date" "$_sub" "$_file" "$_line" "${1:-Unknown Error}"
}

# info "Download completel"
#   $1  required    The string to log
#
function info () {
    local _date _line _sub _file

    _date="$(command -p date "$_date_format")"
    read -r _line _sub _file < <(caller 0)

    printf "${blue}INFO${reset}    [%s] <%s@%s:%s> %s\n" "$_date" "$_sub" "$_file" "$_line" "${1:-Unknown Error}"
}

# warn "Outdated version, consider updating"
#   $1  required    The string to log
#
function warn () {
    local _date _line _sub _file

    _date="$(command -p date "$_date_format")"
    read -r _line _sub _file < <(caller 0)

    printf "${yellow}WARN${reset}    [%s] <%s@%s:%s> %s\n" "$_date" "$_sub" "$_file" "$_line" "${1:-Unknown Error}"
}

# error "Cloud not download dependency: $dep"
#   $1  required    The string to log
#
function error () {
    local _date _line _sub _file

    _date="$(command -p date "$_date_format")"
    read -r _line _sub _file < <(caller 0)

    >&2 printf "${red}ERROR${reset}   [%s] <%s@%s:%s> %s\n" "$_date" "$_sub" "$_file" "$_line" "${1:-Unknown Error}"
    [ "${_backtrace:-FALSE}" == FALSE ] || print_backtrace 1
}

# die "Cannot open file: $file" 2
#   $1  required    The string to log
#   $2  optional    The exit code (defaults: 1)
#
function die () {
    local _date

    _date="$(command -p date "$_date_format")"
    >&2 printf "${red}${bold}FATAL${reset}   [%s] %s\n" "$_date" "${1:-Unknown Error}"

    print_backtrace 1

    exit "${2:-1}"
}

# print_backtrace 1
#   $1  optional    non-negative integer representing stack frame (defaults: 0)
#
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
