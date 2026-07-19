#!/bin/bash

LOCALDIR=SDG-WAYSHELL-CONFIGS
DOCDIR=SDG-WAYSHELL-CONFIGS
TIPDIR=SDG-WAYSHELL-CONFIGS

WORKDIR=$(pwd)

rm -rf "$HOME/.local/docs/$DOCDIR" "$HOME/.local/tips/$TIPDIR" "$HOME/.local/SDG-MONOCLE"

cp -r "$WORKDIR/config/"* "$HOME/.config/" 2>/dev/null || true
cp -r "$WORKDIR/local/"* "$HOME/.local/"
cp -r "$WORKDIR/docs/"* "$HOME/.local/docs/"
cp -r "$WORKDIR/tips/"* "$HOME/.local/tips/"

chmod a+x "$HOME/.config/SDG-WAYSHELL-CONFIGS/"*/*.sh
chmod a+x "$HOME/.local/SDG-MONOCLE/"*.sh
