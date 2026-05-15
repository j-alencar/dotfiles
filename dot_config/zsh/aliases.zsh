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
