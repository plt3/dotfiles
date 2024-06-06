#!/usr/bin/env sh

# https://apple.stackexchange.com/questions/188169/what-is-the-default-blue-value-for-applehighlightcolor
# to change highlight color

COLOR=0xff9dd274
if [ "$MODE" = "" ]; then
	COLOR=0xffff6578
fi

sketchybar --set svim.mode label="[$MODE]" \
	label.drawing=$(if [ "$MODE" = "" ]; then echo "off"; else echo "on"; fi) \
	icon.color=$COLOR
