#!/usr/bin/env bash

source lib/setup.sh

taps=(
    homebrew/cask-fonts
)

bottles=(
    git
    go
    jq
    shellcheck
    stow
    vim
)

casks=(
    alfred
    daisydisk
    docker
    font-jetbrains-mono
    google-chrome
    google-drive
    iterm2
    jetbrains-toolbox
    rectangle
    signal
    slack
    spotify
    textual
    visual-studio-code
    whatsapp
)

configs=(
    git-base
    git-home
    sh-base
    sh-home
    vim
)

parse_flags "$@"
require_homebrew
install_taps "${taps[@]}"
install_bottles "${bottles[@]}"
install_casks "${casks[@]}"
install_configs "${configs[@]}"
setup_omz
print_errors_and_exit
