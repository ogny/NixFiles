#!/bin/bash
dosya=$1
egrep -wir $dosya --exclude-dir=.git *
