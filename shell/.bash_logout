#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091
#
# executed by bash(1) when login shell exits.
#

should_kill_ssh_agent() {
    [[ -x /usr/bin/ssh-agent ]] &&
    [[ -n "${SSH_AGENT_PID}" ]] &&
    [[ -z "${TMUX}" ]]
}

if should_kill_ssh_agent; then
    ssh-agent -k
fi

unset should_kill_ssh_agent

# when leaving the console clear the screen to increase privacy
if [[ "${SHLVL}" -eq 1 ]]; then
    if [[ -x /usr/bin/clear_console ]]; then
        /usr/bin/clear_console -q
    elif [[ -x /usr/bin/clear ]]; then
        /usr/bin/clear
    elif [[ -x /usr/bin/tput ]]; then
        /usr/bin/tput clear
    fi
fi
