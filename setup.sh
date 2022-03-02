#!/usr/bin/env bash

# Require Brew

if ! command -v brew >/dev/null ; then
    echo 'Install Homebrew first. Follow the instructions at https://brew.sh/'
    exit 1
fi

# Add Homebrew taps

taps=(
    homebrew/cask-fonts
)

for i in "${taps[@]}" ; do
    brew tap "$i"
done

# Install Homebrew bottles

bottles=(
    colordiff
    git
    gnupg
    go
    shellcheck
    stow
    vim
)

for i in  "${bottles[@]}" ; do
    if ! brew list "$i" ; then
        brew install "$i"
    fi
done

# Install Homebrew casks

casks=(
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

for i in "${casks[@]}" ; do
    if ! brew list --cask "$i" ; then
        brew install --cask "$i"
    fi
done

# Stow configurations

configs=(
    git
    sh
    vim
)

for i in "${configs[@]}" ; do
    stow "$i"
done

# Install Oh My ZSH!

if [ ! -d ~/.oh-my-zsh ] ; then
    KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
