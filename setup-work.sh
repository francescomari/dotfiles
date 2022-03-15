#!/usr/bin/env bash

source lib/setup.sh

parse_flags "$@"

require_homebrew

install_taps \
    homebrew/cask-fonts \
    ngrok/ngrok

install_bottles \
    fnm \
    git \
    gnupg \
    go \
    jq \
    ngrok \
    pinentry-mac \
    postgresql@13 \
    redis \
    shellcheck \
    stow \
    vim

install_casks \
    alfred \
    cmake \
    daisydisk \
    docker \
    font-jetbrains-mono \
    google-chrome \
    google-drive \
    iterm2 \
    jetbrains-toolbox \
    postico \
    rectangle \
    signal \
    slack \
    spotify \
    textual \
    visual-studio-code \
    whatsapp \
    zoom

install_configs \
    git-base \
    git-work \
    sh-base \
    sh-work \
    vim

setup_omz

setup_gnupg

print_errors_and_exit
