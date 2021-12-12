#!/usr/bin/env bash

export HUES_USER='wLHmCI4-d8MaV6vRVtYxHIHeChYapv-pVvMnpjt2'
export HUES_IP='192.168.1.73'

function ht () {
    { hue light toggle 3 --ip "$HUES_IP" --user "$HUES_USER" &
      hue light toggle 4 --ip "$HUES_IP" --user "$HUES_USER"; } &>/dev/null
}
