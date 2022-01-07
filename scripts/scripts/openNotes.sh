#!/bin/bash

# this script opens up neovim with (hopefully) the correct note I want to edit.
# Alias a nice command ("note") to this file, and then invoke it with note subject
# or just note to get to the index page.

if [ $1 ]; then
    cd ~/vimwiki/
    # this passes all the files tracked by git and with the query into fzf
    wantedFile=$(rg --files | rg -i $1 | fzf -i -1 -0 -q $1)
    if [ $wantedFile ]; then
        # if inside tmux, rename window to something descriptive
        if [ -n "$TMUX" ]; then
            paneTitle=$(basename -s .md $wantedFile | xargs basename -s _notes | tr "_" " ")
            if [ "$paneTitle" = "index" ]; then
                tmux rename-window "notes"
            else
                tmux rename-window "$paneTitle notes"
            fi
        fi
        wantedPath=~/vimwiki/$wantedFile
        nvim $wantedPath
    else
        if [ -n "$TMUX" ]; then
            tmux rename-window "notes"
        fi
        nvim ~/vimwiki/index.md
    fi
else
    if [ -n "$TMUX" ]; then
        tmux rename-window "notes"
    fi
    nvim ~/vimwiki/index.md
fi

# if in tmux, make sure that the window automatically renames itself after this script
if [ -n "$TMUX" ]; then
    tmux set-option -w automatic-rename on
fi
