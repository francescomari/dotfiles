#!/usr/bin/env bash

source lib/setup.sh

parse_flags "$@"

require_homebrew

install_taps \
    homebrew/cask-fonts

install_bottles \
    git \
    go \
    jq \
    shellcheck \
    stow \
    vim

install_casks \
    alfred \
    daisydisk \
    docker \
    font-jetbrains-mono \
    google-chrome \
    google-drive \
    iterm2 \
    jetbrains-toolbox \
    rectangle \
    signal \
    slack \
    spotify \
    textual \
    visual-studio-code \
    whatsapp

install_configs \
    git-base \
    git-home \
    sh-base \
    sh-home \
    vim

setup_omz

print_errors_and_exit
