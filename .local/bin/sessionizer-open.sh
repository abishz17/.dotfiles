#!/usr/bin/env bash

MODE="terminal"
if [ "$1" = "--opencode" ]; then
  MODE="opencode"
  shift
elif [ "$1" = "--split" ]; then
  MODE="split"
  shift
fi

TARGET="$1"

if [ -z "$TARGET" ]; then
  exit 1
fi

NAME="$(basename "$TARGET")"
case "$MODE" in
  opencode) TAB_TITLE="oc:${NAME}" ;;
  split) TAB_TITLE="dev:${NAME}" ;;
  *) TAB_TITLE="$NAME" ;;
esac

# ---------- Rex ----------
# Each project is a window (tab) in the current Rex session, labelled TAB_TITLE.

rex_cmd() {
  if command -v rex >/dev/null 2>&1; then
    rex "$@"
  else
    "$REX_BIN_DIR/rex" "$@"
  fi
}

rex_open() {
  local session="$REX_SESSION" existing created shell_block

  # Focus the tab if one with this exact label already exists
  existing="$(rex_cmd window ls -s "$session" --json |
    jq -r --arg l "$TAB_TITLE" '[.windows[] | select(.label == $l) | .window_id][0] // empty')"
  if [ -n "$existing" ]; then
    rex_cmd window focus -s "$session" "$existing"
    return
  fi

  case "$MODE" in
    opencode)
      rex_cmd window new -s "$session" "$TAB_TITLE" -c "$TARGET" -- opencode
      ;;
    split)
      created="$(rex_cmd window new -s "$session" "$TAB_TITLE" -c "$TARGET" --json)" || return 1
      shell_block="$(printf '%s' "$created" | jq -er '.block_ids[0]')" || return 1
      # Split right and run opencode, keeping focus on the shell
      rex_cmd split -s "$session" -b "$shell_block" --split=right -c "$TARGET" --focus=false -- opencode
      ;;
    *)
      rex_cmd window new -s "$session" "$TAB_TITLE" -c "$TARGET"
      ;;
  esac
}

# ---------- kitty ----------

kitty_open() {
  # Prefer kitty's exported socket address; fall back to the legacy fixed path
  local KITTY_SOCKET="${KITTY_LISTEN_ON:-unix:/tmp/mykitty-${KITTY_PID}}"

  case "$MODE" in
    opencode)
      kitty @ --to "$KITTY_SOCKET" focus-tab --match "title:^${TAB_TITLE}$" 2>/dev/null ||
        kitty @ --to "$KITTY_SOCKET" launch --type=tab \
          --tab-title "$TAB_TITLE" \
          --cwd "$TARGET" \
          opencode
      ;;
    split)
      if kitty @ --to "$KITTY_SOCKET" focus-tab --match "title:^${TAB_TITLE}$" 2>/dev/null; then
        return 0
      fi
      kitty @ --to "$KITTY_SOCKET" launch --type=tab \
        --tab-title "$TAB_TITLE" \
        --cwd "$TARGET"
      # Split right and run opencode
      kitty @ --to "$KITTY_SOCKET" launch --location=vsplit \
        --match "title:^${TAB_TITLE}$" \
        --cwd "$TARGET" \
        opencode
      kitty @ --to "$KITTY_SOCKET" focus-window --match recent:1 2>/dev/null
      ;;
    *)
      kitty @ --to "$KITTY_SOCKET" focus-tab --match "title:^${TAB_TITLE}$" 2>/dev/null ||
        kitty @ --to "$KITTY_SOCKET" launch --type=tab \
          --tab-title "$TAB_TITLE" \
          --cwd "$TARGET"
      ;;
  esac
}

# ---------- pick the terminal we're running in ----------

if [ -n "$REX_SESSION" ]; then
  rex_open
elif [ -n "$KITTY_LISTEN_ON" ] || [ -n "$KITTY_PID" ]; then
  kitty_open
else
  echo "sessionizer: unsupported terminal (TERM_PROGRAM=${TERM_PROGRAM:-unknown})" >&2
  exit 1
fi
