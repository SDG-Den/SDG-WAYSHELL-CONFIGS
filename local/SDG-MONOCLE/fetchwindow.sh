#!/bin/bash


INDEX="$1"
MONITOR=$2

while [ -e $HOME/.config/SDG-MONOCLE/monocle-$MONITOR.lock ]; do
    sleep 0.01
done

WINDOWTITLE=$(cat $HOME/.config/SDG-MONOCLE/monocle-$MONITOR.state | grep -e "index:$INDEX" | cut -d'\' -f2 | xargs)




echo "$WINDOWTITLE"
