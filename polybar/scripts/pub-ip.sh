#!/bin/sh

# credits
# https://linuxconfig.org/polybar-a-better-wm-panel-for-your-linux-system

IP=$(dig +short ip92.ip-51-83-138.eu @1.1.1.1)

if pgrep -x wireguard > /dev/null; then
    echo $IP
else
    echo $IP
fi
