#!/bin/bash
gunun_tablosu="$(date +%d_%m_%Y)"
cp ~/Git_Repolari/kisisel/public/belgeler/Diger/Bahis_template.md ~/bet/$gunun_tablosu.md
cd ~/bet
sudo nohup /home/orkung/.npm-packages/bin/markserv -a 0.0.0.0 -p 80 &
