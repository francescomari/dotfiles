#!/usr/bin/env sh

# Install Brew
if ! command -v brew >/dev/null ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install Oh My ZSH!
if [ ! -d ~/.oh-my-zsh ] ; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# Install Brew casks
for i in \
    alfred \
    java \
    slack \
    spotify \
    visual-studio-code \
    whatsapp \
    signal \
    daisydisk \
    skype \
    rectangle \
    iterm2 \
    1password
do
    brew install $i
done

# Brew pacakges
for i in \
    go \
    git \
    maven \
    stow \
    subversion \
    vim \
    colordiff
do
    brew install $i
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
