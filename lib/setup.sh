#!/usr/bin/env bash

# Save stdout and stderr in FD 3 and 4, respectively, and redirect the output to
# /dev/null.

exec 3>&1 4>&2 &>/dev/null

info() {
    echo >&3 "$@"
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

require_homebrew() {
    if ! command -v brew ; then
        fatal 'Install Homebrew first. Follow the instructions at https://brew.sh/'
    fi
}

install_taps() {
    info 'Installing Homebrew taps...'

    for i in "$@" ; do
        info "Installing Homebrew tap '$i'"

        if ! brew tap "$i" ; then
            error "Installation of Homebrew tap '$i' failed"
        fi
    done
}

install_tap_with_url() {
    info "Installing Homebrew tap '$1'"

    if ! brew tap "$i" "$2" ; then
        error "Installation of Homebrew tap '$i' failed"
    fi
}

install_bottles() {
    info 'Installing Homebrew bottles...'

    for i in  "$@" ; do
        if ! brew list "$i" ; then
            info "Installing Homebrew bottle '$i'"

            if ! brew install "$i" ; then
                error "Installation of Homebrew bottle '$i' failed"
            fi
        else
            info "Homebrew bottle '$i' already installed"
        fi
    done
}

install_casks() {
    info 'Installing Homebrew casks...'

    for i in "$@" ; do
        if ! brew list --cask "$i" ; then
            info "Installing Homebrew cask '$i'"

            if ! brew install --cask "$i" ; then
                error "Installation of Homebrew cask '$i' failed"
            fi
        else
            info "Homebrew cask '$i' already installed"
        fi
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
    if [ ! -d ~/.oh-my-zsh ] ; then
        info 'Installing Oh My ZSH!'

        if ! KEEP_ZSHRC=yes RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ; then
            error 'Installation of Oh My ZSH! failed'
        fi
    else
        info 'Oh My ZSH! already installed'
    fi
}

setup_gnupg() {
    local gpg_config
    local gpg_config_dir
    local gpg_config_file

    gpg_config="pinentry-program $(which pinentry-mac)"
    gpg_config_dir=~/.gnupg
    gpg_config_file="$gpg_config_dir/gpg-agent.conf"

    if ! grep -qxF "$gpg_config" "$gpg_config_file" ; then
        info 'Configuring GPG'

        if [ ! -d "$gpg_config_dir" ] ; then
            mkdir -p "$gpg_config_dir"
        fi

        echo "$gpg_config" >>"$gpg_config_file"
    else
        info 'GPG already configured'
    fi
}

print_errors_and_exit() {
    if [ ${#errors[@]} -gt 0 ] ; then
        info "Setup errors:"

        for e in "${errors[@]}" ; do
            info " * $e"
        done

        exit 1
    fi

    exit 0
}
