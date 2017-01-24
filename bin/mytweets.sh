#!/bin/bash
source $HOME/.profile
TARIH=$(date +"%Y-%m-%d_%H:%M")
DOSYA="$HOME/Downloads/gunun_tweetleri/$TARIH"
t="/home/orkung/.rvm/gems/ruby-2.1.1/bin/t"
touch $DOSYA 
$t list timeline @orkungunay/kiymetliler -n 20 > $DOSYA
$t list timeline @orkungunay/hobi -n 20 >> $DOSYA; \
$t list timeline @orkungunay/tech -n 20 >> $DOSYA; \
$t list timeline @orkungunay/diger -n 5 >> $DOSYA; \

