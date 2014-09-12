#!/bin/bash
scrot -s ~/ekran_goruntuleri/ekran_goruntusu.png
echo '<html><body><img src="ekran_goruntusu.png" /></body></html>' > ~/ekran_goruntuleri/index.html
#x-terminal-emulator -vb +sb -fg NavajoWhite1 -bg black -cr yellow \
#-fn "misc-fixed-medium-f-normal--18-120-100-100-c-90-iso10654-1" \
#-T "Capture Screen" -e /bin/bash -c \
xterm -T "Capture Screen" -e /bin/bash -c \
"/sbin/ifconfig eth | grep 'inet addr:' | cut -d: -f2 | cut -d' ' -f1; \
echo -e '\n\n'; \
cd ~/ekran_goruntuleri && python -m SimpleHTTPServer 9999"
