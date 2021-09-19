#!/usr/bin/env sh

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
for i in \
    1password \
    alfred \
    colordiff \
    daisydisk \
    git \
    go \
    iterm2 \
    java \
    maven \
    rectangle \
    signal \
    skype \
    slack \
    spotify \
    stow \
    subversion \
    vim \
    visual-studio-code \
    whatsapp
do
    if brew list -q $i ; then
        echo "Formula '$i' is alredy installed"
    else
        brew install $i
    fi
done

# Configuration files
for i in \
    sh \
    git \
    gvim \
    subversion \
    vim
do
    stow $i
done
