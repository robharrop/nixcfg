#!/usr/bin/env sh

source "${HOME}/.config/sketchybar/colours.sh"
source "${HOME}/.config/sketchybar/icons.sh"

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
    exit 0
fi

case ${PERCENTAGE} in
[8-9][0-9] | 100)
    ICON="${BATTERY_100}"
    ICON_COLOR="${DRACULA_PINK}"
    ;;
7[0-9])
    ICON="${BATTERY_75}"
    ICON_COLOR="${DRACULA_PINK}"
    ;;
[4-6][0-9])
    ICON="${BATTERY_50}"
    ICON_COLOR="${DRACULA_PINK}"
    ;;
[1-3][0-9])
    ICON="${BATTERY_25}"
    ICON_COLOR="${DRACULA_YELLOW}"
    ;;
[0-9])
    ICON="${BATTERY_0}"
    ICON_COLOR="${DRACULA_RED}"
    ;;
esac

if [[ $CHARGING != "" ]]; then
    ICON=""
    ICON_COLOR="${DRACULA_COMMENT}"
fi

sketchybar --set $NAME \
    icon=$ICON \
    label="${PERCENTAGE}%" \
    icon.color=${ICON_COLOR}
