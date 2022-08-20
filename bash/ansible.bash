#!/usr/bin/env bash

###########
# Aliases #
###########

#############
# Functions #
#############

function ansible-playbook () {
    case "$1" in
        local)
            shift
            printf 'running local...\n'
            command -p ansible-playbook \
                --connection=local \
                --inventory 127.0.0.1, \
                --limit 127.0.0.1 "$@"
            ;;
        *)
            command -p ansible-playbook "$@"
            ;;
    esac
}
