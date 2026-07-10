#!/bin/bash

# re-deploy scripting + docs/tips only — preserve user configs

# re-deploy monocle scripts
rm -rf $HOME/.local/SDG-MONOCLE
mkdir 
cp -r $HOME/.cache/SDG-PKG/sdg-wayshell-conf/local/* $HOME/.local/
chmod a+x $HOME/.local/SDG-MONOCLE/*.sh

# re-deploy docs and tips
rm -rf $HOME/.local/docs/SDG-WAYSHELL-CONFIGS
rm -rf $HOME/.local/tips/SDG-WAYSHELL-CONFIGS
mkdir -p $HOME/.local/docs
mkdir -p $HOME/.local/tips
cp -r $HOME/.cache/SDG-PKG/sdg-wayshell-conf/docs/* $HOME/.local/docs
cp -r $HOME/.cache/SDG-PKG/sdg-wayshell-conf/tips/* $HOME/.local/tips
