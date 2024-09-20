#!/bin/bash

sketchybar --add event aerospace_workspace_change

SPACES=("1" "2" "3" "4" "5" "6" "7" "8" "9" "0")

for sid in "${SPACES[@]}"
do
  space=(
    label.font="$FONT:Regular:16.0"
    label.padding_right=5
    label.padding_left=5
    label.background.height=26
    label.background.drawing=off
    label.background.color=$DRACULA_PURPLE
    label.background.corner_radius=8
    label.background.drawing=off
    label.drawing=on
    label="$sid"
    script="$PLUGIN_DIR/aerospace.sh $sid"
    click_script="aerospace workspace $sid"
  )

  sketchybar --add item space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid aerospace_workspace_change
done
