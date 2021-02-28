#!/bin/sh

# credits
# https://linuxconfig.org/polybar-a-better-wm-panel-for-your-linux-system

IP=$(dig +short aopinc.com @1.0.0.1)

if pgrep -x wireguard > /dev/null; then
    echo $IP
else
    echo $IP
fi
