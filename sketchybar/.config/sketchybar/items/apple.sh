#!/usr/bin/env bash

POPUP_OFF='sketchybar --set apple.logo popup.drawing=off'
POPUP_CLICK_SCRIPT='sketchybar --set $NAME popup.drawing=toggle'

apple_logo=(
	icon=$ICON_APPLE
	icon.font="$FONT:Regular:18.0"
	icon.color=$GREEN
	padding_right=10
	icon.y_offset=1
	label.drawing=off
	click_script="$POPUP_CLICK_SCRIPT"
	popup.height=35
)

apple_prefs=(
	icon=$ICON_COG
	label="System Settings"
	click_script="open -a 'System Settings'; $POPUP_OFF"
)

apple_activity=(
	icon=$ICON_CHART
	label="Activity Monitor"
	click_script="open -a 'Activity Monitor'; $POPUP_OFF"
)

apple_lock=(
	icon=$ICON_LOCK
	label="Lock Screen"
	click_script="pmset displaysleepnow; $POPUP_OFF"
)

sketchybar --add item apple.logo left \
	--set apple.logo "${apple_logo[@]}" \
	\
	--add item apple.prefs popup.apple.logo \
	--set apple.prefs "${apple_prefs[@]}" \
	\
	--add item apple.activity popup.apple.logo \
	--set apple.activity "${apple_activity[@]}" \
	\
	--add item apple.lock popup.apple.logo \
	--set apple.lock "${apple_lock[@]}"
