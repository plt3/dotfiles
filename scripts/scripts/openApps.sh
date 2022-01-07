#!/usr/bin/env bash

# Glorified version of just making these apps open on login
# assigned to ctrl + shift + o in karabiner.json

open -a "Messages"
open -a "Calendar"
open -a "Notes"
open -a "Finder"
open -a "iTerm"
open -a "Brave Browser"

sleep 10

say "restarting yuh bye"

launchctl kickstart -k "gui/${UID}/homebrew.mxcl.yabai"

# TODO: tile space 1 windows correctly using yabai
# can also use something like yabai -m rule --add app="Calendar" space=3
