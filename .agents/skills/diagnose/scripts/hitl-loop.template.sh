#!/usr/bin/env bash
# Human-in-the-loop reproduction loop.
# Copy this file, edit the steps below, and run it.
# The agent runs the script; the user follows prompts in their terminal.
#
# Usage:
#   bash hitl-loop.template.sh
#
# Two helpers:
#   step "<instruction>"       → show instruction, wait for Enter
#   capture VAR "<question>"   → show question, read response into VAR (base64-encoded in output)
#
set -uo pipefail

step() {
  printf '\n>>> %s\n' "$1"
  # 'read' is allowed to fail (EOF/no-tty) without killing the script
  read -r -p "    [Enter when done] " _ || true
}

capture() {
  local var="$1" question="$2" answer
  printf '\n>>> %s\n' "$question"
  read -r -p "    > " answer || true
  printf -v "$var" '%s' "$answer"
}

# --- edit below ---------------------------------------------------------
step "Open the app at http://localhost:3000 and sign in."
capture ERRORED "Click the target action. Did it throw an error? (y/n)"
capture ERROR_MSG "Paste the error message (or 'none'):"
# --- edit above ---------------------------------------------------------

printf '\n--- Captured ---\n'
printf 'ERRORED=%s\n' "$ERRORED"
# Free-form fields are base64-encoded to survive newlines and special chars
printf 'ERROR_MSG_B64=%s\n' "$(printf '%s' "$ERROR_MSG" | base64 -w0)"
printf '\n(Decode with: base64 -d <<< "$ERROR_MSG_B64")\n'

