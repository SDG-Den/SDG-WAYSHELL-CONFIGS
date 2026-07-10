#!/bin/bash

WORKDIR="$HOME/.cache/SDG-PKG/sdg-wayshell-conf"

rm -rf "$HOME/.local/SDG-MONOCLE"
cp -r "$WORKDIR/local/"* "$HOME/.local/"

rm -rf "$HOME/.local/docs/SDG-WAYSHELL-CONFIGS" "$HOME/.local/tips/SDG-WAYSHELL-CONFIGS"
cp -r "$WORKDIR/docs/"* "$HOME/.local/docs/"
cp -r "$WORKDIR/tips/"* "$HOME/.local/tips/"

chmod a+x "$HOME/.local/SDG-MONOCLE/"*.sh
