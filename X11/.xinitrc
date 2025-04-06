#!/bin/sh

source "$HOME/.profile"

sysresources="/etc/X11/xinit/.Xresources"
sysmodmap="/etc/X11/xinit/.Xmodmap"

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

userx11dir="$HOME/.config/X11"
userresources="$userx11dir/Xresources"
usermodmap="$userx11dir/Xmodmap"

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
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

xsetroot -cursor_name left_ptr &

while true; do
	setstatusbar
	sleep 1m
done &

xset s 300 5 &

setxkbmap us,se -option caps:escape &

autostart="mpd dunst clipmenu"
for program in $autostart; do
	pidof -s "$program" || "program" &
done >/dev/null 2>&1

sxhkd -c "$HOME/.config/sxhkd/sxhkdrc" &

exec startdwm
