#!/bin/sh

# credits
# https://linuxconfig.org/polybar-a-better-wm-panel-for-your-linux-system

IP=$(dig +short ip92.ip-51-83-138.eu @54.38.142.226)

if pgrep -x wireguard > /dev/null; then
    echo n193: $IP
else
    echo n193: $IP
fi
