#!/usr/bin/env bash

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

sketchybar --set "$NAME" background.drawing="$SELECTED" \
	icon.highlight="$SELECTED" \
	label.highlight="$SELECTED"

# seems like space_windows_change events gets sent from every space to every space,
# so check that space that sent event is same as space that is handling it
CHANGED_SPACE=$(echo $INFO | jq '.space')
if [ "$SENDER" = "space_windows_change" ] && [ "$SID" = "$CHANGED_SPACE" ]; then
	LABEL=""

	APPS=$(echo $INFO | jq '.apps | keys_unsorted[]')

	if grep -q "\"" <<<$APPS; then
		APPS_ARR=()
		while read -r line; do APPS_ARR+=("$line"); done <<<"$APPS"

		LENGTH=${#APPS_ARR[@]}
		for j in "${!APPS_ARR[@]}"; do
			APP=$(echo ${APPS_ARR[j]} | sed 's/"//g')
			ICON=$($CONFIG_DIR/plugins/app_icon.sh "$APP")
			LABEL+="$ICON"
			if [[ $j < $(($LENGTH - 1)) ]]; then
				LABEL+=" "
			fi
		done
	else
		LABEL+="_"
	fi

	sketchybar --set "$NAME" label="$LABEL"
fi
