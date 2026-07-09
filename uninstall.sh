#!/bin/bash

# remove scripting only — preserve user configs
rm -rf $HOME/.local/SDG-MONOCLE
rm -rf $HOME/.local/docs/SDG-WAYSHELL-CONFIGS
rm -rf $HOME/.local/tips/SDG-WAYSHELL-CONFIGS

# remove executable permissions from waybar config scripts
chmod -x $HOME/.config/SDG-WAYSHELL-CONFIGS/*/*.sh 2>/dev/null || true
