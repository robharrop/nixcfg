clock=(
  icon=cal
  icon.font="$FONT:Bold:13.0"
  icon.padding_right=0
  label.width=45
  label.align=right
  padding_right=10
  padding_left=15
  update_freq=30
  script="$PLUGIN_DIR/clock.sh"
)

sketchybar --add item clock right       \
           --set clock "${clock[@]}" \
           --subscribe clock system_woke