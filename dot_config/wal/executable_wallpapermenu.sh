#!/bin/bash
WALLPAPER_DIR="${HOME}/wallpapers"

if [[ -n "$1" ]]; then
    CHOICE="$1"
else
    if command -v feh &>/dev/null; then
        CHOICE="$(feh -t "$WALLPAPER_DIR"/* 2>/dev/null | head -1)"
    fi

    if [[ -z "$CHOICE" ]] && command -v rofi &>/dev/null; then
        CHOICE="$(find "$WALLPAPER_DIR" -type f \( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.webp' \) -printf '%f\n' | sort | rofi -dmenu -p 'Wallpaper')"
        [[ -n "$CHOICE" ]] && CHOICE="${WALLPAPER_DIR}/${CHOICE}"
    fi
fi

if [[ -z "$CHOICE" || ! -f "$CHOICE" ]]; then
    echo "No wallpaper selected."
    exit 1
fi

wal -i "$CHOICE" -o ~/.config/wal/post-wal.sh
