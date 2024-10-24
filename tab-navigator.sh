#!/bin/bash
# Function to create a new WezTerm tab with specified directory
create_wezterm_tab() {
    local dir="$1"
    wezterm cli spawn --cwd "$dir" > /dev/null 2>&1
}
# If we're already in WezTerm
if [ -n "$WEZTERM_PANE" ]; then
    # Use fzf to select directory from specified paths
    selected_dir=$(find ~ ~/personal ~/work -mindepth 1 -maxdepth 1 -type d | fzf)

    if [ -n "$selected_dir" ]; then
        create_wezterm_tab "$selected_dir"
    fi
else
    # If not in WezTerm, start a new WezTerm instance in current directory
    wezterm start --cwd "$PWD" > /dev/null 2>&1
fi
