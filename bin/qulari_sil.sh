#!/bin/bash
tar -cjvf backup-$(date --date="1 months ago" +%Y-%m-%d).tar.bz2 `find ~/calisma/ -name "*c*" -type f`
mv backup-$(date --date="1 months ago" +%Y-%m-%d).tar.bz2 ~/
find ~/calisma/ -name "*q*" -type f -exec rm -f {} \;
