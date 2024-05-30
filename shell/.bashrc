#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091
#
# executed by bash(1) for interactive, non-login shells.
#

# If not running interactively, don't do anything
if [[ "$-" != *i* ]]; then
  return
fi

# Format history
# ==============

shopt -s histappend
set +H
export HISTSIZE=100000
export HISTFILESIZE=200000
export HISTCONTROL=erasedups:ignorespace

# Set various bash options
# ========================

shopt -s cdspell checkwinsize dirspell direxpand

# Shell completion
# ================

if [[ -f /usr/share/bash-completion/bash_completion ]]; then
  source /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
  source /etc/bash_completion
fi

if [[ -f /usr/share/git/completion/git-prompt.sh ]]; then
  source /usr/share/git/completion/git-prompt.sh
fi

# Source configuration files
# ==========================

shell_config_dir="${HOME}/.local/lib/shell"

for shell_file in aliases environment functions prompt 'local'; do
  if [[ -f "${shell_config_dir}/${shell_file}" ]]; then
    source "${shell_config_dir}/${shell_file}"
  fi
done

unset shell_file
unset shell_config_dir

if command -v starship >/dev/null; then
  eval "$(starship init bash)"
fi
