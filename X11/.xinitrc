#!/bin/sh

source "$HOME/.profile"

while true; do
	xsetroot -name "$( date +"%F %R" )"
	sleep 1m
done &

exec startdwm
