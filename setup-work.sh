#!/usr/bin/env bash

source lib/setup.sh

bottles=(
    aws-vault
    awscli
    azure-cli
    caarlos0/tap/svu
    circleci
    cloc
    direnv
    dive
    fnm
    fx
    ghcup
    git
    gnupg
    go
    golangci-lint
    goreleaser
    hashicorp/tap/terraform
    helm
    jq
    kubectx
    miniscruff/changie/changie
    mitmproxy
    mockery
    node
    opa
    oras
    pinentry-mac
    postgresql@13
    python
    redis
    remotemobprogramming/brew/mob
    shellcheck
    shellspec/shellspec/shellspec
    snyk/tap/snyk
    stow
    tctl
    teleport
    tilt-dev/tap/tilt
    tree
    vim
    watch
)

casks=(
    1password-cli
    alfred
    cmake
    daisydisk
    discord
    docker
    google-cloud-sdk
    google-drive
    homebrew/cask-fonts/font-jetbrains-mono
    iterm2
    jetbrains-toolbox
    ngrok
    postico
    postman
    rectangle
    signal
    skype
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
    git-work
    sh-base
    sh-work
    vim
)

parse_flags "$@"
require_homebrew
install_tap_with_url miniscruff/changie https://github.com/miniscruff/changie
install_bottles "${bottles[@]}"
check_unmanaged_bottles "${bottles[@]}"
install_casks "${casks[@]}"
check_unmanaged_casks "${casks[@]}"
install_configs "${configs[@]}"
setup_omz
setup_gnupg
print_errors_and_exit
