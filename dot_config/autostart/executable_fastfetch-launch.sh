#!/bin/bash
wezterm start --class fastfetch --config initial_cols=100 --config initial_rows=30 -- bash -c "fastfetch; exec zsh" &
WEZPID=$!

sleep 1.5

dbus-send --type=method_call --dest=org.kde.KWin /Scripting org.kde.kwin.Scripting.start string:"
var w = workspace.windowList();
for (var i = 0; i < w.length; i++) {
    if (w[i].resourceClass === 'fastfetch') {
        w[i].keepAbove = true;
        w[i].frameGeometry = Qt.rect(200, 100, 960, 540);
    }
}
" 2>/dev/null

wait $WEZPID
