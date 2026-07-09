#!/bin/bash


ACTIVEMON=$2
INDEX="$1"
while [ -e $HOME/.config/SDG-MONOCLE/monocle-$ACTIVEMON.lock ]; do
    sleep 0.01
    echo "sleeping"
done


echo "activemon is $ACTIVEMON"
ACTIVETAG=$(mmsg get tags $ACTIVEMON | jq '.tags[] | select(.is_active == true) | .index' -r)
echo "activetag is $ACTIVETAG"

WINDOWID=$(cat $HOME/.config/SDG-MONOCLE/monocle-$ACTIVEMON.state | grep -e "index:$INDEX" | cut -d'\' -f3 | xargs)
WINDOWtitle=$(cat $HOME/.config/SDG-MONOCLE/monocle-$ACTIVEMON.state | grep -e "index:$INDEX" | cut -d'\' -f2 | xargs)


echo "moving window $WINDOWID"

mmsg dispatch focusid client,$WINDOWID
