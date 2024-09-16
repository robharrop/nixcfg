#!/usr/bin/env bash

status_bracket=(
  background.color=$DRACULA_CURRENT_LINE
  background.border_color=$DRACULA_COMMENT
  background.border_width=1
  background.corner_radius=9
  background.height=27
)

sketchybar --add bracket status volume volume_icon battery \
           --set status "${status_bracket[@]}"