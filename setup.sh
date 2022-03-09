#!/usr/bin/env bash

# Setup configuration.

taps=(
    homebrew/cask-fonts
)

bottles=(
    colordiff
    fnm
    git
    gnupg
    go
    pinentry-mac
    shellcheck
    stow
    vim
)

casks=(
    alfred
    cmake
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
    zoom
)

configs=(
    git
    sh
    vim
)

# Parse options.

verbose=0

while [ $# -gt 0 ] ; do
    case $1 in
        -v)
            verbose=1
            shift
            ;;
        -*)
            echo >&2 "Unrecognized option '$1'"
            exit 1
            ;;
        *)
            echo >&2 "Unrecognized argument '$1"
            exit 1
            ;;
    esac
done

# Redirect stdout/stderr, but save stdout's FD in 3.

if [ $verbose -eq 0 ] ; then
    exec 3>&1 &>/dev/null
else
    exec 3>&1
fi

# Whatever is printed with log() will always be printed on stdout.

log() {
    echo >&3 "$@"
}

# Require Brew.

if ! command -v brew ; then
    log 'Install Homebrew first. Follow the instructions at https://brew.sh/'
    exit 1
fi

# Add Homebrew taps.

log 'Installing Homebrew taps...'

for i in "${taps[@]}" ; do
    log "Installing Homebrew tap '$i'"

    if ! brew tap "$i" ; then
        errors+=("Installation of Homebrew tap '$i' failed")
    fi
done

# Install Homebrew bottles.

log 'Installing Homebrew bottles...'

for i in  "${bottles[@]}" ; do
    if ! brew list "$i" ; then
        log "Installing Homebrew bottle '$i'"

        if ! brew install "$i" ; then
            errors+=("Installation of Homebrew bottle '$i' failed")
        fi
    else
        log "Homebrew bottle '$i' already installed"
    fi
done

# Install Homebrew casks

log 'Installing Homebrew casks...'

for i in "${casks[@]}" ; do
    if ! brew list --cask "$i" ; then
        log "Installing Homebrew cask '$i'"

        if ! brew install --cask "$i" ; then
            errors+=("Installation of Homebrew cask '$i' failed")
        fi
    else
        log "Homebrew cask '$i' already installed"
    fi
done

# Stow configurations

log 'Installing Stow configurations...'

for i in "${configs[@]}" ; do
    log "Installing Stow configuration '$i'"

    if ! stow "$i" ; then
        errors+=("Installation of Stow configuration '$i' failed")
    fi
done

# Install Oh My ZSH!.

if [ ! -d ~/.oh-my-zsh ] ; then
    log 'Installing Oh My ZSH!'

    if ! KEEP_ZSHRC=yes RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ; then
        errors+=('Installation of Oh My ZSH! failed')
    fi
else
    log 'Oh My ZSH! already installed'
fi

# Update or initialize the GPG configuration

gpg_config="pinentry-program $(which pinentry-mac)"
gpg_config_dir=~/.gnupg
gpg_config_file="$gpg_config_dir/gpg-agent.conf"

if ! grep -qxF "$gpg_config" "$gpg_config_file" ; then
    log 'Configuring GPG'

    if [ ! -d "$gpg_config_dir" ] ; then
        mkdir -p "$gpg_config_dir"
    fi

    echo "$gpg_config" >>"$gpg_config_file"
else
    log 'GPG already configured'
fi

# Print errors and terminate with a non-zero exit code.

if [ ${#errors[@]} -gt 0 ] ; then
    log "Setup errors:"

    for e in "${errors[@]}" ; do
        log " * $e"
    done

    exit 1
fi
