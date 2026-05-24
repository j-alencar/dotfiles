# WSL distro shortcuts (only when running inside WSL)
if [[ -f /proc/version ]] && grep -qi microsoft /proc/version 2>/dev/null; then
    alias fd='wsl.exe -d Fedora'
    alias ol='wsl.exe -d OracleLinux'
    alias db='wsl.exe -d Debian'
fi

,keys() {
    local cheatsheet="${CHEZMOI_SOURCE_DIR:-$HOME/dotfiles}/KEYBINDINGS.md"
    if command -v bat &>/dev/null; then
        bat --style=plain --language=md "$cheatsheet"
    elif command -v glow &>/dev/null; then
        glow "$cheatsheet"
    else
        less "$cheatsheet"
    fi
}

,sandcastle() {
    echo "run cd new-repo && sandcastle-init"
    echo "then edit tasks in .sandcastle/main.mts"
    echo "then npm run sandcastle"
}

,sandcastle-logs() {
    local logdir=".sandcastle/logs"
    if [[ ! -d "$logdir" ]]; then
        echo "no .sandcastle/logs/ in current directory"
        return 1
    fi
    if [[ "$1" == "--watch" ]]; then
        shift
        local pattern="${1:-*}"
        tail -f "$logdir"/$~pattern.log
    else
        local pattern="${1:-*}"
        tail -20 "$logdir"/$~pattern.log
    fi
}
