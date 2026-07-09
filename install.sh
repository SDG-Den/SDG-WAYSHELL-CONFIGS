#!/bin/bash

### dependencies
unipkg install any sdg-wayshell

# set working directory
WORKDIR=$HOME/.cache/SDG-PKG/sdg-wayshell-conf

# install configs with subdirectory structure preserved
mkdir -p $HOME/.config/SDG-WAYSHELL-CONFIGS
cp -r $WORKDIR/config/wayshellconf/* $HOME/.config/SDG-WAYSHELL-CONFIGS/

# install monocle configs
mkdir -p $HOME/.config/SDG-MONOCLE
cp -r $WORKDIR/config/SDG-MONOCLE/* $HOME/.config/SDG-MONOCLE/

# install monocle scripts
mkdir -p $HOME/.local/SDG-MONOCLE
cp -r $WORKDIR/local/SDG-MONOCLE/* $HOME/.local/SDG-MONOCLE/

# install docs and tips
mkdir -p $HOME/.local/docs
mkdir -p $HOME/.local/tips
cp -r $WORKDIR/docs/* $HOME/.local/docs
cp -r $WORKDIR/tips/* $HOME/.local/tips

# make scripts executable
chmod a+x $HOME/.config/SDG-WAYSHELL-CONFIGS/*/*.sh
chmod a+x $HOME/.local/SDG-MONOCLE/*.sh
