if [[ "$OSTYPE" == linux* ]]; then
    export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/ssh-agent.socket"
    if ! ssh-add -l &>/dev/null; then
        ssh-agent -a "$SSH_AUTH_SOCK" > /dev/null 2>&1 || true
        ssh-add ~/.ssh/gh 2>/dev/null || true
        ssh-add ~/.ssh/ado 2>/dev/null || true
    fi
fi
