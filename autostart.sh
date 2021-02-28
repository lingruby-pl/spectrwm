#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

# export GTK2_RC_FILES="/home/lingruby/.gtkrc-2.0"
# export QT_QPA_PLATFORMTHEME="qt5ct"
export TIME_STYLE='+%a %d %b %Y %H%M%S'

# Find out your monitor name with xrandr or arandr (save and you get this line)
# picom -b --config /home/lingruby/.config/spectrwm/picom.conf &

# Some ways to set your wallpaper besides variety or nitrogen
# sh /home/lingruby/Skrypt_start/i3-nitrogen.sh  &

# Some ways to set your bar
# sh /home/lingruby/.config/spectrwm/polybar/launch.sh &
# /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# sh /home/lingruby/.config/spectrwm/conky/conky_start.sh &
# run numlockx on &
# run volumeicon &
# run nm-applet &
# run octopi-notifier &
# run redshift-qt &
# run megasync &
# run keepassxc &
wine start "C:\\Program Files (x86)\\Zegarynka\\Zegarynka.exe" &
# run lightscreen &
lxsu sh /usr/local/bin/ifconfig.sh &
run psi &
run qtox &
run owncloud &
# run mailspring &
# run blueman-applet &

echo "AutoStart SpectrWM by LinGruby-Mod..."
