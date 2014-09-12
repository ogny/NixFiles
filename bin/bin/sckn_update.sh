#!/bin/bash
cd ~/uzak_repolar/scknco/
git pull
rsync -avh ./ ~/beyaz/2013_doc_beyaz_belgeler/notlar/Seckin_notlar/
cd
