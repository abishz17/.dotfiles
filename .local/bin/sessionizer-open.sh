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

KITTY_SOCKET="unix:/tmp/mykitty-${KITTY_PID}"
TAB_TITLE="$(basename "$TARGET")"

case "$MODE" in
  opencode)
    TAB_TITLE="oc:${TAB_TITLE}"
    kitty @ --to "$KITTY_SOCKET" focus-tab --match "title:^${TAB_TITLE}$" 2>/dev/null ||
      kitty @ --to "$KITTY_SOCKET" launch --type=tab \
        --tab-title "$TAB_TITLE" \
        --cwd "$TARGET" \
        opencode
    ;;
  split)
    TAB_TITLE="dev:${TAB_TITLE}"
    if kitty @ --to "$KITTY_SOCKET" focus-tab --match "title:^${TAB_TITLE}$" 2>/dev/null; then
      exit 0
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
