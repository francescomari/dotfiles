#!/usr/bin/env bash

source lib/setup.sh

configs=(
    git-base
    git-home
    sh-base
    sh-home
    vim
)

parse_flags "$@"
require_homebrew
install_brewfile Brewfile.home
check_unmanaged_brewfile Brewfile.home
install_configs "${configs[@]}"
setup_omz
print_errors_and_exit
