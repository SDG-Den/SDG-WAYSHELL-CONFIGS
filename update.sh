#!/bin/bash

rm -rf /home/$(whoami)/.config/SDG-WAYSHELL-CONFIGS
cp -r /home/$(whoami)/.cache/SDG-PKG/sdg-wayshell-conf/config/wayshellconf/* /home/$(whoami)/.config/SDG-WAYSHELL-CONFIGS/

rm -rf /home/$(whoami)/.local/docs/SDG-WAYSHELL-CONFIGS
rm -rf /home/$(whoami)/.local/tips/SDG-WAYSHELL-CONFIGS
mkdir -p /home/$(whoami)/.local/docs
mkdir -p /home/$(whoami)/.local/tips
cp -r /home/$(whoami)/.cache/SDG-PKG/sdg-wayshell-conf/docs/* /home/$(whoami)/.local/docs
cp -r /home/$(whoami)/.cache/SDG-PKG/sdg-wayshell-conf/tips/* /home/$(whoami)/.local/tips
