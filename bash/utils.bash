function tz () {
    declare -a _zones
    declare -i _zone_width=0
    declare -i _interrupt=1

    # gum only
    if ! command -v gum >/dev/null 2>&1; then
        error 'Required command “gum” not installed'
        return
    fi

    while true; do

        # Print selected zones
        if [ "${#_zones[@]}" -gt 0 ]; then
            command -p clear
            command gum style --foreground 212 --border-foreground 212 --border double \
                --align center --width 50 --margin "1 2" --padding "2 4" \
                "${_zones[@]}"
        fi

        # Prompt for more zones after 2 selected
        if [ "${#_zones[@]}" -ge 2 ] || [ $_interrupt -eq 0 ] \
            && ! gum confirm 'Select another time zone?'; then
            break
        fi

        # Select zone
        declare _zone="$(_tz_select "${_zones[*]}")"

        # Dynamically set zone width
        [ "${#_zone}" -gt "$_zone_width" ] && _zone_width="${#_zone}"

        # Append new zones
        if [ "$_zone"x = x ]; then
            _interrupt=0
        else
            _zones+=( "$_zone" )
        fi
    done

    # Nothing to compare if less than 2 time zones
    if [ "${#_zones[@]}" -lt 2 ]; then
        return
    fi

    # Append row/element
    declare -a _output=('Zone,Current,-3,-2,-1,Now,1,2,3,')
    for _zone in "${_zones[@]}"; do
        declare _ranges="$(_tz_range "$_zone")"
        _output+=( "$(printf '%s,%s,%s' "$_zone" "$(TZ="$_zone" date '+%c')" "$_ranges")" )
    done;

    # Pass output to gum
    printf '%s\n' "${_output[@]}" | gum table -w "${_zone_width}",35,2,2,2,3,2,2,2

}

function _tz_range () {
    declare -r _zone="$1"
    declare -a hours=( {00..23} )
    declare -r -a _offset=(-3 -2 -1 0 1 2 3)
    declare -i hour="$(TZ="$_zone" date '+%H')"

    declare -a _range
    for i in "${_offset[@]}"; do

        # Rotate through our array
        i="$((hour+i))"
        [ "$i" -gt 23 ] && i="$((i%23))"

        # Append
        _range+=( "${hours[$i]}" )
    done

    printf '%d,' "${_range[@]}"
}

function _tz_select () {
    declare -r _placeholder="$1"
    declare -r _dir='/usr/share/zoneinfo'

    find "$_dir" \! \( -path "$_dir/posix/*" -o -path "$_dir/right/*" \)  \
            -type l -printf '%P\n' | command gum filter --placeholder "$_placeholder"
}
