#!/usr/bin/env bash

# focused app
sketchybar --add item chevron left \
	--set chevron icon= label.drawing=off \
	--set chevron padding_right=-5 \
	--add item front_app left \
	--set front_app script="$PLUGIN_DIR/front_app.sh" \
	--subscribe front_app front_app_switched
