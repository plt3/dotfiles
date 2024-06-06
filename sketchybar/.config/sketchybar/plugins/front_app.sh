#!/usr/bin/env bash

if [ "$SENDER" = "front_app_switched" ]; then
	sketchybar --set "$NAME" icon=$($CONFIG_DIR/plugins/app_icon.sh "$INFO") label="$INFO"
fi
