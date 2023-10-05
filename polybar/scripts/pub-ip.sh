#!/bin/sh

# credits
# https://linuxconfig.org/polybar-a-better-wm-panel-for-your-linux-system

IP=$(dig +short vps-ee58364b.vps.ovh.net @1.1.1.1)
PING=$(ping -W 1 -c 1 51.83.187.31 -q | grep rtt | grep -E [0-9]+\.[0-9]+ -o | head -n 2 | tail -n 1)

if pgrep -x wireguard > /dev/null; then
    echo kvm: $IP ping: $PING
else
    echo kvm: $IP ping: $PING
fi
