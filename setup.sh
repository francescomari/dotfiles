#!/usr/bin/env bash

# Install Brew

if ! command -v brew >/dev/null ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install Oh My ZSH!

if [ ! -d ~/.oh-my-zsh ] ; then
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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
    iterm2
    jetbrains-toolbox
    rectangle
    signal
    skype
    slack
    spotify
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
