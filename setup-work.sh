#!/usr/bin/env bash

source lib/setup.sh

require_internal_tap() {
    if brew tap | grep '^experience-platform/internal$' ; then
        return
    fi

    info 'Installing the internal tap...'

    if ! brew tap --force-auto-update experience-platform/homebrew-internal git@git.corp.adobe.com:experience-platform/homebrew-internal.git ; then
        fatal 'Unable to install the internal tap'
    fi
}

install_skyline_cli() {
    if [ -d "$HOME/.sky" ] ; then
        return
    fi

    info 'Installing the Skyline CLI...'

    if ! git clone git@git.corp.adobe.com:experience-platform/skyline-cli.git ~/.sky ; then
        fatal 'Unable to clone the Skyline CLI'
    fi

    ln -s "$HOME/.sky/bin/sky" "$HOME/bin/sky"
}

bottles=(
    azure-cli
    bash
    bats-core
    cloc
    conftest
    coreutils
    direnv
    dive
    dprint
    experience-platform/internal/cmcli
    experience-platform/internal/skyline-ops-cli
    fd
    fnm
    fx
    fzf
    git
    gitslave
    gnu-sed
    go
    goreleaser
    hashicorp/tap/vault
    helix
    helm
    jenv
    jq
    kind
    kubeconform
    kubectx
    lazygit
    marksman
    maven
    mkcert
    mongodb-atlas-cli
    node
    operator-sdk
    parallel
    php
    postgresql@14
    prometheus
    pyright
    python
    python-tk@3.13
    rbenv
    ripgrep
    ruby
    ruby-lsp
    ruff
    shellcheck
    stow
    taplo
    tree
    vim
    watch
    yamllint
    yq
)

casks=(
    1password
    1password-cli
    alfred
    daisydisk
    discord
    docker
    font-jetbrains-mono
    font-jetbrains-mono-nerd-font
    google-drive
    iterm2
    jetbrains-toolbox
    mitmproxy
    ngrok
    obsidian
    rectangle
    signal
    spotify
    textual
    visual-studio-code
    vlc
    whatsapp
    zoom
)

configs=(
    dprint
    git-base
    git-work
    helix
    maven
    sh-base
    sh-work
    vim
)

parse_flags "$@"
require_homebrew
require_internal_tap
install_skyline_cli
install_bottles "${bottles[@]}"
check_unmanaged_bottles "${bottles[@]}"
install_casks "${casks[@]}"
check_unmanaged_casks "${casks[@]}"
install_configs "${configs[@]}"
setup_omz
print_errors_and_exit
