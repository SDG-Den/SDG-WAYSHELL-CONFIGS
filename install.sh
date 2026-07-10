#!/bin/bash

### dependencies
unipkg install any sdg-wayshell

WORKDIR="$HOME/.cache/SDG-PKG/sdg-wayshell-conf"

cp -r "$WORKDIR/config/"* "$HOME/.config/"
cp -r "$WORKDIR/local/"* "$HOME/.local/"
cp -r "$WORKDIR/docs/"* "$HOME/.local/docs/"
cp -r "$WORKDIR/tips/"* "$HOME/.local/tips/"

chmod a+x "$HOME/.config/SDG-WAYSHELL-CONFIGS/"*/*.sh
chmod a+x "$HOME/.local/SDG-MONOCLE/"*.sh
