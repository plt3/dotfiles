#!/usr/bin/env bash

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"; do
	sid=$(($i + 1))

	space=(
		space=$sid
		icon="${SPACE_ICONS[i]}"
		icon.padding_left=10
		icon.padding_right=5
		padding_left=2
		padding_right=2
		label.padding_right=10
		icon.highlight_color=$RED
		label.color=$GREY
		label.highlight_color=$WHITE
		background.color=$BACKGROUND_1
		background.border_color=$BACKGROUND_2
		script="$PLUGIN_DIR/space.sh"
	)

	sketchybar --add space space.$sid left \
		--set space.$sid "${space[@]}"
done

space_creator=(
	icon=
	padding_left=10
	label.drawing=off
	icon.padding_right=0
	script="$PLUGIN_DIR/space_windows.sh"
	icon.color=$WHITE
)

sketchybar --add item space_creator left \
	--set space_creator "${space_creator[@]}" \
	--subscribe space_creator space_windows_change
