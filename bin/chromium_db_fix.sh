#!/bin/sh
IFS="
"
for I  in `file ~/.config/google-chrome/Default/*|grep SQL|cut -f1 -d:`; do echo '.dump' | sqlite3 $I > ${I}.sql && rm $I && sqlite3 $I < ${I}.sql && rm ${I}.sql ; done

