#!/usr/bin/env bash

source lib/setup.sh

taps=(
    homebrew/cask-fonts
    ngrok/ngrok
)

bottles=(
    fnm
    git
    gnupg
    go
    jq
    ngrok
    pinentry-mac
    postgresql@13
    redis
    shellcheck
    stow
    vim
)

casks=(
    alfred
    cmake
    daisydisk
    docker
    font-jetbrains-mono
    google-chrome
    google-drive
    iterm2
    jetbrains-toolbox
    notion
    postico
    rectangle
    signal
    slack
    spotify
    textual
    visual-studio-code
    whatsapp
    zoom
)

configs=(
    git-base
    git-work
    sh-base
    sh-work
    vim
)

parse_flags "$@"
require_homebrew
install_taps "${taps[@]}"
install_bottles "${bottles[@]}"
install_casks "${casks[@]}"
install_configs "${configs[@]}"
setup_omz
setup_gnupg
print_errors_and_exit
