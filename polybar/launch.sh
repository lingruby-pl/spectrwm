#!/usr/bin/env sh

# More info : https://github.com/jaagr/polybar/wiki

# Terminate already running bar instances
killall -q polybar


# Wait until the processes have been shut down
  while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

    if type "xrandr" > /dev/null; then
    polybar --reload mainbar-eDP1 -c ~/.config/spectrwm/polybar/config &
    polybar --reload mainbar-DP1 -c ~/.config/spectrwm/polybar/config &
    fi

echo "Start Polybar by LinGruby-Mod..."
