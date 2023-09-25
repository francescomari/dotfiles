#!/usr/bin/env bash

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
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# OMZ configuration
configure_omz

# Environment-specific stuff
if [ -f "$HOME/.zshrc-env" ] ; then
    source "$HOME/.zshrc-env"
fi

# Compile and run a C++ file
crun() {
    cleanup() {
        rm a.out >/dev/null 2>&1
    }

    trap cleanup EXIT

    g++ -o a.out "$1" && ./a.out
}
