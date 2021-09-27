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

# Brew formulas
formulas=(
    1password
    alfred
    colordiff
    daisydisk
    git
    go
    goland
    intellij-idea
    iterm2
    java
    maven
    rectangle
    shellcheck
    signal
    skype
    slack
    spotify
    stow
    subversion
    vim
    visual-studio-code
    whatsapp
)

for i in  "${formulas[@]}" ; do
    if ! brew list "$i" ; then
        brew install "$i"
    fi
done

# Stow configurations
configs=(
    git
    gvim
    maven
    sh
    subversion
    vim
)

for i in "${configs[@]}" ; do
    stow "$i"
done
