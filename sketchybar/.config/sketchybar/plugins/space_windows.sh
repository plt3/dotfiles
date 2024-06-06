#!/usr/bin/env bash

if [ "$SENDER" = "space_windows_change" ]; then
	space="$(echo "$INFO" | jq -r '.space')"
	apps="$(echo "$INFO" | jq -r '.apps | keys[]')"

	icon_strip=""
	if [ "${apps}" != "" ]; then
		while read -r app; do
			ICON=$($CONFIG_DIR/plugins/app_icon.sh "$app")
			icon_strip+=" $ICON"
		done <<<"${apps}"
	else
		icon_strip=" —"
	fi
	icon_strip=$(echo "$icon_strip" | sed -e 's/^[[:space:]]*//')

	sketchybar --animate sin 10 --set space.$space label="$icon_strip"
fi
