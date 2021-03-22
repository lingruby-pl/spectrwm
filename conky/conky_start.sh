#!/bin/sh
killall conky

conky -c "/home/lingruby/.config/spectrwm/conky/conky" &
conky -c "/home/lingruby/.config/spectrwm/conky/conky_clock" &
conky -c "/home/lingruby/.config/spectrwm/conky/conky_txt" &

exit
