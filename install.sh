#!/bin/bash

### dependencies
unipkg install any sdg-wayshell

# set working directory
WORKDIR=/home/$(whoami)/.cache/SDG-PKG/sdg-wayshell-conf

# install configs with subdirectory structure preserved
mkdir -p /home/$(whoami)/.config/SDG-WAYSHELL-CONFIGS
cp -r $WORKDIR/config/wayshellconf/* /home/$(whoami)/.config/SDG-WAYSHELL-CONFIGS/

# install docs and tips
mkdir -p /home/$(whoami)/.local/docs
mkdir -p /home/$(whoami)/.local/tips
cp -r $WORKDIR/docs/* /home/$(whoami)/.local/docs
cp -r $WORKDIR/tips/* /home/$(whoami)/.local/tips

# make scripts executable
chmod a+x /home/$(whoami)/.config/SDG-WAYSHELL-CONFIGS/*/*.sh
