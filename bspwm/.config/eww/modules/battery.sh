#!/bin/sh

BATTERY="BAT0"

function print_battery() {
  status=$(cat "/sys/class/power_supply/$BATTERY/status")

  cap=$(cat "/sys/class/power_supply/$BATTERY/capacity")
  [[ "$status" == "Full" ]] && cap="100"
  [ "$cap" -gt "97" ] && cap="100"

  icon=""
  if [ "$cap" -gt 0 ] && [ "$cap" -le 10 ]; then
    icon="󰢜"
    [[ "$status" == "Discharging" ]] && icon="󰁺"
  elif [ "$cap" -gt 10 ] && [ "$cap" -le 20 ]; then
    icon="󰂆"
    [[ "$status" == "Discharging" ]] && icon="󰁻"
  elif [ "$cap" -gt 20 ] && [ "$cap" -le 30 ]; then
    icon="󰂇"
    [[ "$status" == "Discharging" ]] && icon="󰁼"
  elif [ "$cap" -gt 30 ] && [ "$cap" -le 40 ]; then
    icon="󰂈"
    [[ "$status" == "Discharging" ]] && icon="󰁽"
  elif [ "$cap" -gt 40 ] && [ "$cap" -le 50 ]; then
    icon="󰢝"
    [[ "$status" == "Discharging" ]] && icon="󰁾"
  elif [ "$cap" -gt 50 ] && [ "$cap" -le 60 ]; then
    icon="󰂉"
    [[ "$status" == "Discharging" ]] && icon="󰁿"
  elif [ "$cap" -gt 60 ] && [ "$cap" -le 70 ]; then
    icon="󰢞"
    [[ "$status" == "Discharging" ]] && icon="󰂀"
  elif [ "$cap" -gt 70 ] && [ "$cap" -le 80 ]; then
    icon="󰂊"
    [[ "$status" == "Discharging" ]] && icon="󰂁"
  elif [ "$cap" -gt 80 ] && [ "$cap" -le 90 ]; then
    icon="󰂋"
    [[ "$status" == "Discharging" ]] && icon="󰂂"
  else
    icon="󰂄"
    [[ "$status" == "Discharging" ]] && icon="󰁹"
  fi

  echo "(box :class \"battery\" :orientation \"h\" :space-evenly false (label :text \"$icon  $cap\"))"
}

print_battery
