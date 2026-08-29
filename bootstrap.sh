#!/usr/bin/env bash
# Set up a fresh machine from this repo. Idempotent - safe to re-run any time;
# every step checks before it acts, and nothing is overwritten in place.
#
#   git clone https://github.com/abishz17/.dotfiles.git ~/.dotfiles
#   cd ~/.dotfiles && ./bootstrap.sh
#
# Re-run it after pulling changes to pick up new Brewfile entries.
set -euo pipefail

cd "$(dirname "$0")"
OS="$(uname -s)"

step() { printf '\n\033[1m==> %s\033[0m\n' "$1"; }
skip() { printf '    already done: %s\n' "$1"; }

# ---------------------------------------------------------------- Homebrew ---
step "Homebrew"
if ! command -v brew >/dev/null 2>&1; then
    if [ "$OS" = "Darwin" ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "    no brew and this is not macOS - install it yourself if you want it, skipping"
    fi
fi
# The prefix differs per platform; put brew on PATH for the rest of this script.
for p in /opt/homebrew /usr/local /home/linuxbrew/.linuxbrew; do
    [ -x "$p/bin/brew" ] && eval "$("$p/bin/brew" shellenv)" && break
done

if command -v brew >/dev/null 2>&1; then
    step "Brewfile"
    brew bundle install --file=Brewfile
else
    skip "brew not present, Brewfile not applied"
fi

# ---------------------------------------------------------------- oh-my-zsh --
# .zshrc sources $ZSH/oh-my-zsh.sh. It is not a brew package and not vendored
# here, so without this the shell config silently stops loading half way down.
step "oh-my-zsh"
ZSH_DIR="$HOME/.oh-my-zsh"
if [ ! -d "$ZSH_DIR" ]; then
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    skip "$ZSH_DIR"
fi

# Two plugins named in .zshrc that oh-my-zsh does not ship with.
CUSTOM="${ZSH_CUSTOM:-$ZSH_DIR/custom}"
clone_plugin() {
    if [ -d "$CUSTOM/plugins/$1" ]; then
        skip "plugin $1"
    else
        git clone --depth=1 "$2" "$CUSTOM/plugins/$1"
    fi
}
clone_plugin zsh-autosuggestions     https://github.com/zsh-users/zsh-autosuggestions
clone_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting

# --------------------------------------------------------------------- stow --
# Symlinks everything in this repo into $HOME, the same way the README always
# described. Idempotent: re-running on a machine that is already stowed is a
# no-op.
step "stow"
if ! command -v stow >/dev/null 2>&1; then
    echo "    stow is missing - install it (brew install stow) and re-run" >&2
    exit 1
fi
if ! stow --target="$HOME" . 2>/tmp/stow.err; then
    echo
    echo "stow reported conflicts:" >&2
    cat /tmp/stow.err >&2
    cat >&2 <<'MSG'

A conflict means a real file already exists where a symlink should go - normal
on a fresh macOS install, which ships its own .zshrc. Either move the file aside
and re-run, or adopt it into the repo and inspect the difference:

    stow --adopt --target="$HOME" .
    git diff            # what the machine had that the repo did not
    git checkout .      # keep the repo's version, discard the machine's
MSG
    exit 1
fi

# --------------------------------------------------------------------- done --
cat <<'MSG'

Done. Open a new shell.

Not handled here, install by hand if you want them:
  bun, opam, uv, go toolchain, and the AI CLIs on PATH in .zshrc
  (codex, amp, grok, kimi-code, antigravity-ide, codegraph)
Neovim plugins restore themselves from .config/nvim/nvim-pack-lock.json
on first launch.
MSG
