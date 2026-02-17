if [[ -o interactive ]] && command -v fastfetch &>/dev/null && [[ -z "${TMUX_PANE:-}" ]]; then
    fastfetch
fi
