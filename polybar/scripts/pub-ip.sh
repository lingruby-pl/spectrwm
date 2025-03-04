#!/bin/sh

# credits
# https://linuxconfig.org/polybar-a-better-wm-panel-for-your-linux-system

IP=$(dig +short vps-ee58364b.vps.ovh.net @127.0.0.53)
PING=$(ping -W 1 -c 1 51.83.187.31 -q | grep rtt | grep -E [0-9]+\.[0-9]+ -o | head -n 2 | tail -n 1)

if pgrep -x wireguard > /dev/null; then
    echo IP $IP ❱ ping $PING
else
    echo IP $IP ❱ ping $PING
fi
