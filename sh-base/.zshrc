#!/usr/bin/env bash

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

# OMZ configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Environment-specific stuff
if [ -f "$HOME/.zshrc-env" ] ; then
    source "$HOME/.zshrc-env"
fi
