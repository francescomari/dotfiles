#!/usr/bin/env sh

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

# Run E2E tests for EaaS
eaas_e2e() {
    if [ $# -lt 1 ] ; then
        echo >&2 "usage: $0 dev|stage|prod [args...]"
        return 1
    fi

    case $1 in
        dev)
            EAAS_API_ENDPOINT=$EAAS_E2E_DEV_API_ENDPOINT
            IMS_URL=$EAAS_E2E_DEV_IMS_URL
            JWT_ISSUER=$EAAS_E2E_DEV_JWT_ISSUER
            JWT_SUBJECT=$EAAS_E2E_DEV_JWT_SUBJECT
            JWT_CLIENT_ID=$EAAS_E2E_DEV_JWT_CLIENT_ID
            JWT_KEY=$EAAS_E2E_DEV_JWT_KEY
            JWT_CLIENT_SECRET=$EAAS_E2E_DEV_JWT_CLIENT_SECRET
            ;;
        stage)
            EAAS_API_ENDPOINT=$EAAS_E2E_STAGE_API_ENDPOINT
            IMS_URL=$EAAS_E2E_STAGE_IMS_URL
            JWT_ISSUER=$EAAS_E2E_STAGE_JWT_ISSUER
            JWT_SUBJECT=$EAAS_E2E_STAGE_JWT_SUBJECT
            JWT_CLIENT_ID=$EAAS_E2E_STAGE_JWT_CLIENT_ID
            JWT_KEY=$EAAS_E2E_STAGE_JWT_KEY
            JWT_CLIENT_SECRET=$EAAS_E2E_STAGE_JWT_CLIENT_SECRET
            ;;
        prod)
            EAAS_API_ENDPOINT=$EAAS_E2E_PROD_API_ENDPOINT
            IMS_URL=$EAAS_E2E_PROD_IMS_URL
            JWT_ISSUER=$EAAS_E2E_PROD_JWT_ISSUER
            JWT_SUBJECT=$EAAS_E2E_PROD_JWT_SUBJECT
            JWT_CLIENT_ID=$EAAS_E2E_PROD_JWT_CLIENT_ID
            JWT_KEY=$EAAS_E2E_PROD_JWT_KEY
            JWT_CLIENT_SECRET=$EAAS_E2E_PROD_JWT_CLIENT_SECRET
            ;;
        *)
            echo >&2 "error: invalid environment: $1"
            return 1
    esac

    shift

    # Export the required variables in a subshell, so we don't pollute the
    # current session.

    (
        export EAAS_API_ENDPOINT
        export IMS_URL
        export JWT_ISSUER
        export JWT_SUBJECT
        export JWT_CLIENT_ID
        export JWT_KEY
        export JWT_CLIENT_SECRET

        go test "$@"
    )
}

run_playbook() {
    if [ $# -lt 2 ] ; then
        echo >&2 "usage: $0 dev|stage|prod playbook"
        return 1
    fi

    case $1 in
        dev)
            ANSIBLE_PASSWORD=$ANSIBLE_PASSWORD_DEV
            ANSIBLE_INVENTORY=inventory/dev
            ;;
        stage)
            ANSIBLE_PASSWORD=$ANSIBLE_PASSWORD_STAGE
            ANSIBLE_INVENTORY=inventory/stage
            ;;
        prod)
            ANSIBLE_PASSWORD=$ANSIBLE_PASSWORD_PROD
            ANSIBLE_INVENTORY=inventory/prod
            ;;
        *)
            echo >&2 "error: invalid environment: $1"
            return 1
    esac

    # Create a temporary password file.

    PASSWORD_FILE=$(mktemp vault-XXXXXX)
    echo "$ANSIBLE_PASSWORD" >"$PASSWORD_FILE"

    # Run the playbook and save the return code.

    ansible-playbook "$2" -i "$ANSIBLE_INVENTORY" --vault-password-file "$PASSWORD_FILE"
    ANSIBLE_RETURN=$?

    # Remove the teporary password file.

    rm "$PASSWORD_FILE"

    # Return whatever Ansible returned.

    return $ANSIBLE_RETURN
}

# Load credentials, if provided.
if [ -f "$HOME/credentials.sh" ] ; then
    # shellcheck disable=SC1091
    . "$HOME/credentials.sh"
fi
