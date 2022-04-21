#!/bin/sh
echo 128000 > /proc/sys/vm/min_free_kbytes &
#/sbin/ifconfig lo txqueuelen 0 &
#/sbin/ifconfig lo mtu 90000 up &
#/sbin/ifconfig enp1s0f1 txqueuelen 200 &
#/sbin/ifconfig enp1s0f1 mtu 1500 up &
#/sbin/ifconfig wg0 txqueuelen 200 &
#/sbin/ifconfig wg0 mtu 1492 up &
#/sbin/ifconfig wlp2s0 txqueuelen 200 &
#/sbin/ifconfig wlp2s0 mtu 1500 up &
sysctl vm.swappiness=1 &
systemctl restart anydesk
