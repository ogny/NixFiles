#!/bin/bash
for i in $(ls); do
        mplayer -slave -input file=/tmp/mplayer-control -lavdopts threads=2 *
done

