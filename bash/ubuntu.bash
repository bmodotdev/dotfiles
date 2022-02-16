#!/usr/bin/env bash

#############
# Functions #
#############

function apt_list () {
    local _pkg
    _pkg="$1"
    [[ -v _pkg ]] || { >&2 printf 'Please provide a package name\n'; exit 1; }

    local url="$(command apt download "$_pkg" --print-uris)"
    [[ x"$url" ==  x ]] && return

    url="${url%% *}"; url="${url:1}"; url="${url::-1}"
    command curl -skL "$url" | command dpkg-deb -c /dev/stdin
}
