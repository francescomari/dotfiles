#!/usr/bin/env bash

source lib/setup.sh

repositories=(
    ppa:longsleep/golang-backports
)

packages=(
    build-essential
    ca-certificates
    curl
    golang
    maven
    openjdk-21-jdk
    python3
    rbenv
    ruby
    stow
    zsh
)

configs=(
    git-base
    git-home
    sh-base
    sh-ubuntu
    vim
)

install_repositories() {
    local repository

    info "Installing APT repositories..."

    for repository in "${repositories[@]}" ; do
        if ! sudo add-apt-repository -y "$repository" ; then
            fatal "Adding repository $repository failed"
        fi
    done
}

install_packages() {
    info "Installing APT packages..."

    if ! sudo apt update ; then
        fatal 'APT update failed'
    fi

    if ! sudo apt-get install -y "$@" ; then
        fatal 'Installation of APT pacakges failed'
    fi
}

install_nodejs() {
    info "Installing Node.js..."

    if commands_exist node npm ; then
        info 'Node.js is already installed'
        return
    fi

    if ! curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash - ; then
        fatal 'Adding Node.js repository failed'
    fi

    if ! sudo apt-get install -y nodejs ; then
        fatal 'Installation of Node.js failed'
    fi
}

install_docker() {
    info "Installing Docker..."

    if command_exists docker ; then
        info 'Docker is already installed'
        return
    fi

    if ! curl -fsSL https://get.docker.com | sudo sh ; then
        fatal 'Installation of Docker failed'
    fi

    info "Adding current user to the Docker group..."

    if ! sudo usermod -aG docker $USER ; then
        fatal 'Adding user to the Docker group failed'
    fi

    info 'Run `newgrp docker` to apply the changes'
}

parse_flags "$@"
install_repositories "${repositories[@]}"
install_packages "${packages[@]}"
install_nodejs
install_docker
install_configs "${configs[@]}"
setup_omz
print_errors_and_exit
