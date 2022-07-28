#!/usr/bin/env bash

SSH_AGENT_KEY_LIFE=86400
export SSH_AGENT_ENV="${HOME}/.ssh/agent.env"
[ -s "$SSH_AGENT_ENV" ] && source "$SSH_AGENT_ENV"

# `man ssh-add`: Exit status is 0 on success,
#   1 if the specified command fails,
#   and 2 if ssh-add is unable to contact the authentication agent.
ssh-add -l >/dev/null 2>&1
if [ $? -eq 2 ]; then
    ssh-agent -s -t "$SSH_AGENT_KEY_LIFE" > "$SSH_AGENT_ENV"
    sed -ri 's/(Agent pid)/SSH \1/' "$SSH_AGENT_ENV"
    source "$SSH_AGENT_ENV"
fi

ssh-add -l
