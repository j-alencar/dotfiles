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
