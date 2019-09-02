#!/usr/bin/env bash

if [ ! -x `command -v brew` ]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew cask install alfred
brew cask install intellij-idea-ce
brew cask install java
brew cask install slack
brew cask install spotify
brew cask install visual-studio-code
brew cask install whatsapp
brew cask install daisydisk
brew cask install skype
brew cask install spectacle
brew cask install macvim

brew install go
brew install git
brew install maven
brew install stow
brew install subversion
brew install vim
brew install colordiff

stow sh
stow git
stow gvim
stow subversion
stow vim