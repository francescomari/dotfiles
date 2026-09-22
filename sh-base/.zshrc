#!/usr/bin/env bash

# Profiliing: uncomment this line.
# zmodload zsh/zprof

configure_omz() {
    export ZSH="$HOME/.oh-my-zsh"

    ZSH_THEME="robbyrussell"

    plugins=(
        git
        golang
    )

    source $ZSH/oh-my-zsh.sh
}

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Default editor
export EDITOR="vim"

# Binary folder
export BIN="$HOME/bin"

# Go
export PATH="$HOME/go/bin:$PATH"

# Generic executables
export PATH="$BIN:$PATH"

# Brew autocompletions
if command -v brew >/dev/null ; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# OMZ configuration
configure_omz

# opam configuration
if [[ -r "${HOME}/.opam/opam-init/init.zsh" ]] ; then
    source /Users/frm/.opam/opam-init/init.zsh  >/dev/null 2>/dev/null
fi

# Activate mise if it's installed
if command -v mise >/dev/null ; then
    eval "$(mise activate zsh)"
fi

# Environment-specific stuff
if [ -f "$HOME/.zshrc-env" ] ; then
    source "$HOME/.zshrc-env"
fi

# Profiling: uncomment this line.
# zprof

# For profiling data, run:
# time zsh -i -c exit
