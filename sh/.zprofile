# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Default editor
export EDITOR="vim"

# Binary folder
export BIN="$HOME/bin"

# Brew installs some executables in /usr/local/sbin
export PATH="/usr/local/sbin:$PATH"

# Go
export PATH="$PATH:$HOME/go/bin"
export GOPRIVATE="git.corp.adobe.com,github.com/adobe,github.com/adobe-private"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Generic executables
export PATH="$BIN:$PATH"

# Maven aliases
alias mci="mvn clean install -DskipTests"
alias mcti="mvn clean install"

# Kubernetes aliases
alias k="kubectl"
alias kc="kubectx"
alias kn="kubens"

# Honest aliases
alias shit=git

# Additional Kuberentes configuration files. Add then only if they exists,
# because some tools will get confused if a Kubernetes configuration file
# doesn't exist.

KUBECONFIG="${HOME}/.kube/config"

if [ -f "${HOME}/src/k8s-kubeconfig/kubeconfig.yaml" ] ; then
    KUBECONFIG="${KUBECONFIG}:${HOME}/src/k8s-kubeconfig/kubeconfig.yaml"
fi

export KUBECONFIG

# Disable some weird configuration so that certain Ansible features work.
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# NVM
export NVM_DIR="$HOME/.nvm"

# Load nvm lazily because it drags on the startup of the shell.
nvm() {
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        unset -f nvm
        source "$NVM_DIR/nvm.sh"
        nvm "$@"
    else
        echo "nvm is not installed"
        return 1
    fi
}

# Open IDEA from the command line
idea() {
    open -na "IntelliJ IDEA.app" --args "$@"
}

# Open Goland from the command line
goland() {
    open -na "GoLand.app" --args "$@"
}

# Load credentials, if provided.
if [ -f "$HOME/credentials.sh" ]; then
    source "$HOME/credentials.sh"
fi
