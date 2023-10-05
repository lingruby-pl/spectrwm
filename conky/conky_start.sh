#!/bin/sh
killall conky -9

conky -c "/home/lingruby/.config/spectrwm/conky/conky_ham-radio" &
conky -c "/home/lingruby/.config/spectrwm/conky/conky_clock" &
conky -c "/home/lingruby/.config/spectrwm/conky/conky_txt" &
conky -c "/home/lingruby/.config/spectrwm/conky/conky" &

exit 0
