#!/usr/bin/env bash

source setup-base.sh

taps+=(
    ngrok/ngrok
)

bottles+=(
    fnm
    gnupg
    ngrok
    pinentry-mac
    postgresql@13
    redis
)

casks+=(
    cmake
    postico
    zoom
)

configs+=(
    git-work
    sh-work
)

setup_gnupg() {
    local gpg_config
    local gpg_config_dir
    local gpg_config_file

    gpg_config="pinentry-program $(which pinentry-mac)"
    gpg_config_dir=~/.gnupg
    gpg_config_file="$gpg_config_dir/gpg-agent.conf"

    if ! grep -qxF "$gpg_config" "$gpg_config_file" ; then
        log 'Configuring GPG'

        if [ ! -d "$gpg_config_dir" ] ; then
            mkdir -p "$gpg_config_dir"
        fi

        echo "$gpg_config" >>"$gpg_config_file"
    else
        log 'GPG already configured'
    fi
}

custom_setup() {
    setup_omz
    setup_gnupg
}
