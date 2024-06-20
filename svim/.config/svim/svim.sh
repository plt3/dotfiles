#!/usr/bin/env sh

# https://apple.stackexchange.com/questions/188169/what-is-the-default-blue-value-for-applehighlightcolor
# to change highlight color

source "$HOME/.config/sketchybar/colors.sh"

COLOR=$GREEN
if [ "$MODE" = "" ]; then
	COLOR=$RED
fi

sketchybar --set svim.mode label="[$MODE]" \
	label.drawing=$(if [ "$MODE" = "" ]; then echo "off"; else echo "on"; fi) \
	icon.color=$COLOR
