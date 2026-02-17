#!/bin/bash
if command -v tmux &>/dev/null && tmux list-sessions &>/dev/null; then
    tmux source-file ~/.cache/wal/colors-tmux.conf 2>/dev/null
fi

if command -v plasma-apply-wallpaperimage &>/dev/null && [[ -n "$1" ]]; then
    plasma-apply-wallpaperimage "$1" 2>/dev/null
fi
