#!/bin/bash

# script to swap current window with window on opposite display

currentDisplay=$(/opt/homebrew/bin/yabai -m query --displays --display | /opt/homebrew/bin/jq '.index')
currentWindow=$(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq '.id')

if [ $currentDisplay == 1 ]
then
    oppositeWindowId=$(/opt/homebrew/bin/yabai -m query --windows --display 2 | /opt/homebrew/bin/jq '.[] | select(."is-visible" == true) | .id')
else
    oppositeWindowId=$(/opt/homebrew/bin/yabai -m query --windows --display 1 | /opt/homebrew/bin/jq '.[] | select(."is-visible" == true) | .id')
fi

/opt/homebrew/bin/yabai -m window --swap $oppositeWindowId

# have to focus opposite window and then window that you ran the command from for it to
# move the mouse lol
/opt/homebrew/bin/yabai -m window --focus $oppositeWindowId
/opt/homebrew/bin/yabai -m window --focus $currentWindow
