#!/usr/bin/env bash

source setup-base.sh

configs+=(
    git-home
    sh-home
)

custom_setup() {
    setup_omz
}
