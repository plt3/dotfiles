#!/bin/bash

# script to switch between monitors reliably (because yabai -m display --focus recent
# sometimes doesn't work)

currentDisplay=$(/opt/homebrew/bin/yabai -m query --displays --display | /opt/homebrew/bin/jq '.index')

if [ $currentDisplay == 1 ]
then
    /opt/homebrew/bin/yabai -m display --focus 2
else
    /opt/homebrew/bin/yabai -m display --focus 1
fi
