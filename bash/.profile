#!/bin/sh

# Default locale
export LC_ALL="en_US"

# Default editor
export EDITOR="vim"

# Binary folder
export BIN="$HOME/bin"

# Go
export PATH="$PATH:$HOME/go/bin"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Generic executables
export PATH="$BIN:$PATH"

# Maven aliases
alias mci="mvn clean install -DskipTests"
alias mcti="mvn clean install"
alias k="kubectl"
