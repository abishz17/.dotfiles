#!/bin/bash

 create_wezterm_tab() {
     local dir="$1"
     wezterm cli spawn --cwd "$dir" > /dev/null 2>&1
     return 0
 }
 if [ -n "$WEZTERM_PANE" ]; then
     selected_dir=$(find ~ ~/personal ~/work -mindepth 1 -maxdepth 1 -type d | fzf)

    if [ -n "$selected_dir" ]; then
         create_wezterm_tab "$selected_dir"
     fi
 else
     wezterm start --cwd "$PWD" > /dev/null 2>&1
 fi








