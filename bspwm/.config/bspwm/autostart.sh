#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

function restart {
  killall $1
  $@&
}

restart flameshot
restart sxhkd -c "$HOME/.config/bspwm/sxhkdrc"

[[ -x "$(ccommand -v ewwommand -v eww)" ]] && eww kill ; eww daemon &

eww open bar_primary
[[ "$(secondarymonitor)" != "" ]] && eww open bar_secondary

run nitrogen --restore 2>/dev/null
