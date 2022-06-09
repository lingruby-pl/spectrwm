#!/bin/sh

connection_status() {
    if [ -f "$config" ]; then
        connection=$(sudo wg show 2>/dev/null | head -n 1 | awk '{print $NF }')

        if [ "$connection" = "$name" ]; then
            echo "1"
        else
            echo "2"
        fi
    else
        echo "3"
    fi
}

name="$1"
# where do you keep your wg config files? make sure you have read access (without sudo)
# if your configs are installed to /etc/wireguard, you need to chmod 755 /etc/wireguard,
# use $name instead of $config in the toggle block, and edit the following path
config="/etc/wireguard/wg0.conf"

case "$2" in
--toggle)
    if [ "$(connection_status)" = "1" ]; then
        sudo wg-quick down "$name" 2>/dev/null
    else
        sudo wg-quick up "$name" 2>/dev/null
    fi
    ;;
*)
    if [ "$(connection_status)" = "1" ]; then
        echo "VPN ON"
        #echo "#1 $name"
        # alternatively use below commands to print VPN's IP/subnet
        # vpn_ip=$(ip a show $name primary | grep "inet" | awk -v OFS="\n" '{ print $2 }')
        # echo $vpn_ip
    elif [ "$(connection_status)" = "3" ]; then
        echo "Config not found!"
    else
        echo "VPN OFF"
        #echo "#2 down"
        # alternatively use a symbol:
        # color="#f90000"
        # echo "%{T2}%{F$color}%{F-T-}"
    fi
    ;;
esac
