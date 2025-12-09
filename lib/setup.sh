#!/usr/bin/env bash

# Save stdout and stderr in FD 3 and 4, respectively, and redirect the output to
# /dev/null.

exec 3>&1 4>&2 &>/dev/null

info() {
    echo >&3 "$@"
}

warn() {
    warnings+=("$1")
}

error() {
    errors+=("$1")
}

fatal() {
    echo >&4 "$1"
    exit 1
}

parse_flags() {
    local verbose

    verbose=0

    while [ $# -gt 0 ] ; do
        case $1 in
            -v)
                verbose=1
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

    if [ $verbose -eq 1 ] ; then
        exec 1>&3 2>&4
    fi
}

command_exists() {
    command -v "$1" > /dev/null 2>&1
}

commands_exist() {
    local c

    for c in "$@" ; do
        if ! command_exists "$c" ; then
            return 1
        fi
    done

    return 0
}

require_homebrew() {
    if ! command_exists brew ; then
        fatal 'Install Homebrew first. Follow the instructions at https://brew.sh/'
    fi
}

install_brewfile() {
    local brewfile="$1"

    info "Installing Brewfile '$brewfile'"

    if ! brew bundle --file="$brewfile" ; then
        error "Installation of Brewfile '$brewfile' failed"
    fi
}

install_tap_with_url() {
    info "Installing Homebrew tap '$1'"

    if ! brew tap "$1" "$2" ; then
        error "Installation of Homebrew tap '$1' failed"
    fi
}

install_bottles() {
    info 'Installing Homebrew bottles...'

    for i in  "$@" ; do
        if  brew list "$i" ; then
            info "Homebrew bottle '$i' already installed"
            continue
        fi

        info "Installing Homebrew bottle '$i'"

        if ! brew install "$i" ; then
            error "Installation of Homebrew bottle '$i' failed"
        fi
    done
}

check_unmanaged_bottles() {
    info 'Checking for unmanaged bottles...'

    for i in $(brew leaves -r) ; do
        for j in "$@" ; do
            if [ "$i" == "$j" ] ; then
                continue 2
            fi
        done

        warn "Bottle '${i}' is not managed by configuration"
    done
}

install_casks() {
    info 'Installing Homebrew casks...'

    for i in "$@" ; do
        if brew list --cask "$i" ; then
            info "Homebrew cask '$i' already installed"
            continue
        fi

        info "Installing Homebrew cask '$i'"

        if ! brew install --cask "$i" ; then
            error "Installation of Homebrew cask '$i' failed"
        fi
    done
}

check_unmanaged_casks() {
    info 'Checking for unmanaged casks...'

    for i in $(brew list --cask) ; do
        for j in "$@" ; do
            if [ "$i" == "${j##*/}" ] ; then
                continue 2
            fi
        done

        warn "Cask '${i}' is not managed by configuration"
    done
}

install_configs() {
    info 'Installing Stow configurations...'

    for i in "$@" ; do
        info "Installing Stow configuration '$i'"

        if ! stow "$i" ; then
            error "Installation of Stow configuration '$i' failed"
        fi
    done
}

setup_omz() {
    if [ -d ~/.oh-my-zsh ] ; then
        info 'Oh My ZSH! already installed'
        return
    fi

    info 'Installing Oh My ZSH!'

    if ! KEEP_ZSHRC=yes RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ; then
        error 'Installation of Oh My ZSH! failed'
    fi
}

print_errors_and_exit() {
    if [ ${#warnings[@]} -gt 0 ] ; then
        info "Warnings:"

        for w in "${warnings[@]}" ; do
            info " * $w"
        done
    fi

    if [ ${#errors[@]} -gt 0 ] ; then
        info "Setup errors:"

        for e in "${errors[@]}" ; do
            info " * $e"
        done

        exit 1
    fi

    exit 0
}
