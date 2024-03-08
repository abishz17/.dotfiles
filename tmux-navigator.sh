#!/usr/bin/env bash

# session=$(find ~ ~/personal ~/raralabs -mindepth 1 -maxdepth 1 -type d  | fzf)
# session_name=$(basename "$session" | tr . _)
#
# if !  tmux has-session -t "$session_name" 2> /dev/null ;  then
#   tmux new-session -s "$session_name" -c "$session" -d 
# fi 
#
# tmux switch-client -t "$session_name"
#
if [ -n "$TMUX" ]; then
  session=$(find ~  ~/personal ~/raralabs -mindepth 1 -maxdepth 1 -type d | fzf)
  session_name=$(basename "$session" | tr . _)

  if ! tmux has-session -t "$session_name" 2> /dev/null; then
    tmux new-session -s "$session_name" -c "$session" -d
  fi

  tmux switch-client -t "$session_name" > /dev/null 2>&1
else
  tmux new-session -s default  -c "$PWD" -d
  tmux attach-session -t default
fi

