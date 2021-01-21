#!/bin/bash
if pgrep -x "picom" > /dev/null
then
	killall picom
else
	picom --config ~/.config/spectrwm/picom.conf
fi
