#!/usr/bin/env bash

# Only show window border when multiple windows in same space
# stolen from https://github.com/koekeishiya/yabai/issues/767

windows="$(yabai -m query --spaces --space | jq '.windows')"

if [[ $windows == *","* ]]
then
  yabai -m config window_border on
else
  yabai -m config window_border off
fi
