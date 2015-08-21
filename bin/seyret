#! /usr/bin/env bash
PLAYER='vlc'
lsof -nP -S2 -bw -u $UID|\
    awk '/\/tmp\/Flash/ { gsub("[^0-9]","",$4); print "/proc/"$2"/fd/"$4 }'|\
    xargs ${PLAYER}
