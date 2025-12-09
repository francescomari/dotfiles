#!/usr/bin/env bash

source lib/setup.sh

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

configs=(
    dprint
    git-base
    git-work
    helix
    maven
    sh-base
    sh-work
    ssh-work
    vim
)

parse_flags "$@"
require_homebrew
install_brewfile Brewfile.work
check_unmanaged_brewfile Brewfile.work
install_skyline_cli
install_configs "${configs[@]}"
setup_omz
print_errors_and_exit
