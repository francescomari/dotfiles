#!/usr/bin/env bash

source lib/setup.sh

bottles=(
    aws-vault
    awscli
    caarlos0/tap/svu
    changie
    circleci
    direnv
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
    mitmproxy
    ngrok/ngrok/ngrok
    node
    opa
    oras
    pinentry-mac
    postgresql@13
    python
    redis
    shellcheck
    shellspec/shellspec/shellspec
    stow
    teleport
    tree
    vim
)

casks=(
    alfred
    cmake
    daisydisk
    docker
    homebrew/cask-fonts/font-jetbrains-mono
    google-cloud-sdk
    google-drive
    iterm2
    jetbrains-toolbox
    postico
    postman
    rectangle
    signal
    skype
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
install_tap_with_url miniscruff/changie https://github.com/miniscruff/changie
install_bottles "${bottles[@]}"
install_casks "${casks[@]}"
install_configs "${configs[@]}"
setup_omz
setup_gnupg
print_errors_and_exit
