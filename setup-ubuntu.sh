#!/usr/bin/env bash

source lib/setup.sh

configs=(
    git-base
    git-home
    sh-base
    sh-ubuntu
    vim
)

parse_flags "$@"
install_configs "${configs[@]}"
setup_omz
print_errors_and_exit
