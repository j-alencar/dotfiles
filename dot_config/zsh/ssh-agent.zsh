if [[ "$OSTYPE" == linux* ]]; then
    export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/ssh-agent.socket"
    if ! ssh-add -l &>/dev/null; then
        rm -f "$SSH_AUTH_SOCK" 2>/dev/null
        ssh-agent -a "$SSH_AUTH_SOCK" > /dev/null 2>&1
        ssh-add -q ~/.ssh/gh 2>/dev/null || true
        ssh-add -q ~/.ssh/ado 2>/dev/null || true
    fi
fi
