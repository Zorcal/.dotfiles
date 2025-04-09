#!/bin/sh

function print_keyboard() {
  layout=$(setxkbmap -query | grep -q 'us' && echo "US" || echo "SE")
  echo "(box :class \"keyboard\" :orientation \"h\" :space-evenly false (label :text \"󰌌  $layout\"))"
}

print_keyboard
