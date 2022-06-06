#!/usr/bin/env bash

source lib/setup.sh

taps=(
    hashicorp/tap
    homebrew/cask-fonts
    ngrok/ngrok
    shellspec/shellspec
)

bottles=(
    aws-vault
    awscli
    circleci
    direnv
    fnm
    git
    gnupg
    go
    goreleaser
    hashicorp/tap/terraform
    jq
    kubectx
    ngrok
    opa
    oras
    pinentry-mac
    postgresql@13
    redis
    shellcheck
    shellspec
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
    google-cloud-sdk
    google-drive
    iterm2
    jetbrains-toolbox
    postico
    rectangle
    signal
    skype
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
