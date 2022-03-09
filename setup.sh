#!/usr/bin/env bash

# Save stdout and stderr in FD 3 and 4, respectively, and redirect the output to
# /dev/null.

exec 3>&1 4>&2 &>/dev/null

# Library functions, used by this and other scripts.

log() {
    echo >&3 "$@"
}

error() {
    errors+=("$1")
}

fatal() {
    echo >&4 "$1"
    exit 1
}

# Parse options.

verbose=0
module=''

while [ $# -gt 0 ] ; do
    case $1 in
        -v)
            verbose=1
            shift
            ;;
        work)
            module='work'
            shift
            ;;
        home)
            module='home'
            shift
            ;;
        -*)
            fatal "Unrecognized option '$1'"
            ;;
        *)
            fatal "Unrecognized argument '$1'"
            ;;
    esac
done

# Restore the original stdout/stderr FDs.

if [ $verbose -eq 1 ] ; then
    exec 1>&3 2>&4
fi

# Source the required configuration.

if [ -z "$module" ] ; then
    fatal "Module not specified. Available values: home, work."
fi

case $module in
    work)
        source setup-work.sh
        ;;
    home)
        source setup-home.sh
        ;;
    *)
        fatal "Unrecognized module '$module'"
        ;;
esac

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
        error "Installation of Homebrew tap '$i' failed"
    fi
done

# Install Homebrew bottles.

log 'Installing Homebrew bottles...'

for i in  "${bottles[@]}" ; do
    if ! brew list "$i" ; then
        log "Installing Homebrew bottle '$i'"

        if ! brew install "$i" ; then
            error "Installation of Homebrew bottle '$i' failed"
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
            error "Installation of Homebrew cask '$i' failed"
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
        error "Installation of Stow configuration '$i' failed"
    fi
done

# Custom setup

custom_setup

# Print errors and terminate with a non-zero exit code.

if [ ${#errors[@]} -gt 0 ] ; then
    log "Setup errors:"

    for e in "${errors[@]}" ; do
        log " * $e"
    done

    exit 1
fi
