#!/bin/bash
source $HOME/.profile
TARIH=$(date +"%Y-%m-%d_%H:%M")
DOSYA="$HOME/gunun_tweetleri/$TARIH"
t="/home/orkung/.rvm/gems/ruby-2.1.1/bin/t"
touch $DOSYA 
$t list timeline @orkungunay/kiymetliler -n 10 > $DOSYA
$t list timeline @orkungunay/hobi -n 15 >> $DOSYA; \
$t list timeline @orkungunay/sanat -n 10 >> $DOSYA; \
$t list timeline @orkungunay/tech -n 10 >> $DOSYA; \
$t list timeline @orkungunay/ekoloji -n 5 >> $DOSYA; \
$t list timeline @orkungunay/aktivizm -n 10 >> $DOSYA; \
$t list timeline @orkungunay/haber -n 5 >> $DOSYA; \
$t list timeline @orkungunay/politics -n 5 >> $DOSYA; \
