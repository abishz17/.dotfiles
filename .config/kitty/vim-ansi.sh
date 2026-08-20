#!/bin/sh

# Paul Nameless's elite buffer cleaning script
# It handles trailing newlines and opens in a responsive Vim terminal
f=$(mktemp /tmp/kitty_buff.XXXXXX)
trap 'rm -f "$f"' EXIT
awk '/^$/ {nlstack=nlstack "\n";next;} {printf "%s",nlstack; nlstack=""; print;}' > "$f"
vim -c "term tail -n 200 $f" -c ':only' -c 'nnoremap q :q!<CR>' -c 'map $ g_' < /dev/tty
