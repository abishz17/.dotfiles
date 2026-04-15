#!/bin/sh

# Paul Nameless's elite buffer cleaning script
# It handles trailing newlines and opens in a responsive Vim terminal
cat - | awk '/^$/ {nlstack=nlstack "\n";next;} {printf "%s",nlstack; nlstack=""; print;}' > /tmp/kitty_buff
vim -c 'term tail -n 200 /tmp/kitty_buff' -c ':only' -c 'nnoremap q :q!<CR>' -c 'map $ g_' < /dev/tty
