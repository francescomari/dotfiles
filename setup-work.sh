#!/usr/bin/env bash

source lib/setup.sh

bottles=(
    cloc
    direnv
    dive
    fnm
    fx
    git
    go
    goreleaser
    helm
    jq
    kubectx
    node
    shellcheck
    stow
    tree
    vim
    watch
)

casks=(
    1password
    1password-cli
    alfred
    daisydisk
    discord
    docker
    google-drive
    homebrew/cask-fonts/font-jetbrains-mono
    iterm2
    jetbrains-toolbox
    ngrok
    obsidian
    rectangle
    signal
    skype
    spotify
    textual
    visual-studio-code
    vlc
    whatsapp
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
install_bottles "${bottles[@]}"
check_unmanaged_bottles "${bottles[@]}"
install_casks "${casks[@]}"
check_unmanaged_casks "${casks[@]}"
install_configs "${configs[@]}"
setup_omz
print_errors_and_exit
