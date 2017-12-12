#!/usr/bin/env bash

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install \
    go \
    git \
    maven \
    stow \
    subversion \
    vim

brew cask install \
    google-chrome \
    alfred \
    intellij-idea-ce \
    java \
    slack \
    spotify \
    visual-studio-code \
    whatsapp

stow \
    bash \
    git \
    gvim \
    subversion \
    vim
    