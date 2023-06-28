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
    arc
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
    transmission
    visual-studio-code
    vlc
    whatsapp
    zoom
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
check_unmanaged_bottles "${bottles[@]}"
install_casks "${casks[@]}"
check_unmanaged_casks "${casks[@]}"
install_configs "${configs[@]}"
setup_omz
print_errors_and_exit
