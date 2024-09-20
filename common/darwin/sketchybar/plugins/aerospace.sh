#!/usr/bin/env bash

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME label.background.drawing=on
else
    sketchybar --set $NAME label.background.drawing=off
fi