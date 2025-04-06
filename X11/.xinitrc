#!/bin/bash

source "$HOME/.profile"

sysresources="/etc/X11/xinit/.Xresources"
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
xrdb -merge <<< "Xcursor.size: 24"

sysmodmap="/etc/X11/xinit/.Xmodmap"
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export WINIT_X11_SCALE_FACTOR=1

xrandr --dpi 96

xset r rate 300 50 &
xset s 300 5 &

xsetroot -cursor_name left_ptr &

setxkbmap us,se -option caps:none &

autostart="mpd dunst clipmenu"
for program in $autostart; do
	pidof -s "$program" || "program" &
done >/dev/null 2>&1

while true; do
    setstatusbar
    sleep 1m
done &

sxhkd -c "$HOME/.config/sxhkd/sxhkdrc" &

exec startdwm
