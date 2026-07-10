#!/bin/bash

### dependencies
unipkg install any sdg-wayshell

# set working directory
WORKDIR=$HOME/.cache/SDG-PKG/sdg-wayshell-conf


# install configs
cp -r $WORKDIR/config/* $HOME/.config

# install scripts
cp -r $WORKDIR/local/* $HOME/.local

# install docs and tips
mkdir -p $HOME/.local/docs
mkdir -p $HOME/.local/tips
cp -r $WORKDIR/docs/* $HOME/.local/docs
cp -r $WORKDIR/tips/* $HOME/.local/tips

# make scripts executable
chmod a+x $HOME/.config/SDG-WAYSHELL-CONFIGS/*/*.sh
chmod a+x $HOME/.local/SDG-MONOCLE/*.sh
