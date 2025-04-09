#!/bin/sh

function icon_volume_text() {
  is_muted=$([[ "$(pactl list sinks | grep '^[[:space:]]Mute:' | awk '{print $2}')" == "yes" ]] && echo 0 || echo 1)
  headphones_connected=$([[ "$(pactl list sinks | grep '^[[:space:]]Active Port:' | awk '{print $3}')" == "analog-output-headphones" ]] && echo 0 || echo 1)
  volume=$(pactl list sinks | grep '^[[:space:]]Volume:' | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

  if [[ $headphones_connected -eq 0 ]]; then
    [[ $is_muted -eq 0 ]] && echo "󰟎 0" || echo "󰋋 $volume"
  else
    [[ $is_muted -eq 0 ]] && echo "󰖁 0" || echo "󰕾 $volume"
  fi
}


function print_volume() {
  read -r icon volume <<< $(icon_volume_text)
  echo "(box :orientation \"h\" :class \"metric volume\" :space-evenly false (box :class \"label\" \"$icon\") (scale :min 0 :max 101 :active false :value \"$volume\" :onchange \"\"))"
}

print_volume
