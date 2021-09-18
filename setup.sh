#!/usr/bin/env zsh

# Install Brew
# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Oh My ZSH!
# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install Brew casks
for i in \
    alfred \
    intellij-idea-ce \
    java \
    slack \
    spotify \
    visual-studio-code \
    whatsapp \
    daisydisk \
    skype \
    spectacle \
    macvim \
    iterm2
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
