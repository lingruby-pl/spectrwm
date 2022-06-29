#!/bin/sh

# credits
# https://linuxconfig.org/polybar-a-better-wm-panel-for-your-linux-system

IP=$(dig +short ip92.ip-51-83-138.eu @54.38.142.226)

if pgrep -x wireguard > /dev/null; then
    echo n193: $IP "ping: $(ping -W 1 -c 1 51.83.138.92 -q | grep rtt | egrep [0-9]+\.[0-9]+ -o | head -n 2 | tail -n 1) ms"
else
    echo n193: $IP "ping: $(ping -W 1 -c 1 51.83.138.92 -q | grep rtt | egrep [0-9]+\.[0-9]+ -o | head -n 2 | tail -n 1) ms"
fi
