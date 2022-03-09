#!/usr/bin/env bash

export taps=(
    homebrew/cask-fonts
)

export bottles=(
    colordiff
    git
    go
    shellcheck
    stow
    vim
)

export casks=(
    alfred
    daisydisk
    font-jetbrains-mono
    google-chrome
    google-drive
    iterm2
    jetbrains-toolbox
    rectangle
    signal
    slack
    spotify
    textual
    visual-studio-code
    whatsapp
)

export configs=(
    git-base
    sh-base
    vim
)

setup_omz() {
    if [ ! -d ~/.oh-my-zsh ] ; then
        log 'Installing Oh My ZSH!'

        if ! KEEP_ZSHRC=yes RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ; then
            error 'Installation of Oh My ZSH! failed'
        fi
    else
        log 'Oh My ZSH! already installed'
    fi
}

custom_setup() {
    return 0
}
