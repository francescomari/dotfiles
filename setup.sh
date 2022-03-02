#!/usr/bin/env bash

# Install Brew

if ! command -v brew >/dev/null ; then
    echo "Installing Homebrew"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed"
fi

# Install Oh My ZSH!

if [ ! -d ~/.oh-my-zsh ] ; then
    echo "Installing Oh My ZSH!"
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My ZSH is already installed"
fi

# Add Homebrew taps

taps=(
    homebrew/cask-fonts
)

for i in "${taps[@]}" ; do
    echo "Adding Homebrew tap '$i'"
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
        echo "Installing Homebrew bottle '$i'"
        brew install "$i"
    else
        echo "Homebrew bottle '$i' is already installed"
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
        echo "Installing Homebrew cask '$i'"
        brew install --cask "$i"
    else
        echo "Homebrew cask '$i' is already installed"
    fi
done

# Stow configurations

configs=(
    git
    sh
    vim
)

for i in "${configs[@]}" ; do
    echo "Stowing configuratino for '$i'"
    stow "$i"
done
