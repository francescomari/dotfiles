#!/usr/bin/env bash

source lib/setup.sh

bottles=(
    fx
    git
    go
    jq
    shellcheck
    stow
    vim
)

casks=(
    1password
    alfred
    daisydisk
    discord
    docker
    google-chrome
    google-drive
    homebrew/cask-fonts/font-jetbrains-mono
    iterm2
    jetbrains-toolbox
    rectangle
    signal
    skype
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
install_bottles "${bottles[@]}"
install_casks "${casks[@]}"
install_configs "${configs[@]}"
setup_omz
print_errors_and_exit
