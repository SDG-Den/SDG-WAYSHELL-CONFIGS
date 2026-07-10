#!/bin/bash

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/wayshell"
VISIBLE_FILE="$CACHE_DIR/bottom_focused_visible"
mkdir -p "$CACHE_DIR"

echo 1 > "$VISIBLE_FILE"

if ! pgrep -f "waybar.*bottom-bar" > /dev/null 2>&1; then
    mmsg dispatch spawn_shell,waybar \
        -c $HOME/.config/SDG-WAYSHELL-CONFIGS/bottom-bar/bottom-bar.json \
        -s $HOME/.config/SDG-WAYSHELL-CONFIGS/bottom-bar/bottom-bar.css
fi
