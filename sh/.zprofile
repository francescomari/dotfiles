#!/usr/bin/env sh

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Default editor
export EDITOR="vim"

# Binary folder
export BIN="$HOME/bin"

# Homebrew configuration
eval "$(brew shellenv)"

# Go
export PATH="$HOME/go/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Generic executables
export PATH="$BIN:$PATH"

# Kubernetes aliases
alias k="kubectl"
alias kc="kubectx"
alias kn="kubens"

# Load credentials, if provided.
if [ -f "$HOME/credentials.sh" ] ; then
    # shellcheck disable=SC1091
    . "$HOME/credentials.sh"
fi
