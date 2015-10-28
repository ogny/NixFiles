#!/bin/bash
exdate="$(date --date='1 months ago' +%Y-%m-%d)"
quota_home="/home/orkung/ptt_quota"
my_archive="$quota_home/procera_quota_csv_archive/"
tar -cjvf $my_archive/backup-cisco-$exdate.tar.bz2 `find $quota_home -mtime 30 -name '*.txt'` 

