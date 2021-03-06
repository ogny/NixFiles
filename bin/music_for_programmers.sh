#!/bin/sh
#
# plays mix from http://musicforprogramming.net in random order

curl -s http://musicforprogramming.net/rss.php \
    | grep comments \
    | sed 's/\s*<.\?comments>\s*//g' \
    | shuf \
    | tr '\n' ' ' \
    | xargs mplayer -slave -input file=/tmp/mplayer-control -nocache 2>&1 >/dev/null
