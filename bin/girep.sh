#!/bin/bash
egrep -wir $1 --exclude-dir=.git *
