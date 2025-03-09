#!/bin/bash
# baraction.sh for spectrwm status bar


## WEATHER
weather() {
	wthr="$(awk '{print}' ~/.config/weather.txt)"
	echo "$wthr"
}




      SLEEP_SEC=2
      #loops forever outputting a line every SLEEP_SEC secs
      while :; do
    echo "$(weather)"
		sleep $SLEEP_SEC
		done
