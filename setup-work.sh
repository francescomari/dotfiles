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
    azure/kubelogin/kubelogin
    bash
    cloc
    coreutils
    direnv
    dive
    experience-platform/internal/cmcli
    experience-platform/internal/skyline-ops-cli
    fnm
    fx
    git
    gitslave
    go
    goreleaser
    helm
    jq
    kubectx
    maven
    mkcert
    node
    parallel
    shellcheck
    stow
    tree
    vim
    watch
    yq
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
