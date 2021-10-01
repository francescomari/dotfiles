#!/usr/bin/env bash

# Install Brew

if ! command -v brew >/dev/null ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install Oh My ZSH!

if [ ! -d ~/.oh-my-zsh ] ; then
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install SDKMAN!

if [ ! -d ~/.sdkman ] ; then
    curl -s "https://get.sdkman.io" | bash
fi

# Brew bottles and casks

bottles=(
    colordiff
    git
    go
    java
    maven
    shellcheck
    stow
    subversion
    vim
)

for i in  "${bottles[@]}" ; do
    if ! brew list "$i" ; then
        brew install "$i"
    fi
done

casks=(
    1password
    alfred
    daisydisk
    goland
    intellij-idea
    iterm2
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
    gvim
    kubectl
    maven
    sh
    subversion
    vim
)

for i in "${configs[@]}" ; do
    stow "$i"
done
