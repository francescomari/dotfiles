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

# Additional Kuberentes configuration files
export KUBECONFIG="${HOME}/.kube/config:${HOME}/src/k8s-kubeconfig/kubeconfig.yaml"

# NVM
export NVM_DIR="$HOME/.nvm"

# Load nvm lazily because it drags on the startup of the shell.
nvm() {
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        unset -f nvm
        source "$NVM_DIR/nvm.sh"
    fi
    nvm "$@"
}

export GOPRIVATE="git.corp.adobe.com,github.com/adobe,github.com/adobe-private"
