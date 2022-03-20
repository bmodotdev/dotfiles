#!/usr/bin/env bash
###########
# Aliases #
###########

#############
# Functions #
#############

function d () {
    case "$1" in
        b)
            shift
            command -p docker build "$@"
            ;;
        c)
            shift
            command -p docker container "$@"
            ;;
        e)
            shift
            command -p docker exec "$@"
            ;;
        i)
            shift
            command -p docker image "$@"
            ;;
        r)
            shift
            command -p docker run "$@"
            ;;
        v)
            shift
            command -p docker volume "$@"
            ;;
        *)
            command -p docker "$@"
            ;;
    esac
}
