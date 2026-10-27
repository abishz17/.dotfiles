# Homebrew sits at a different prefix per platform: /opt/homebrew on Apple
# Silicon, /usr/local on Intel, /home/linuxbrew/.linuxbrew on Linux. Resolve it
# once so nothing below has to hardcode a path.
for __brew in /opt/homebrew /usr/local /home/linuxbrew/.linuxbrew; do
  if [ -x "$__brew/bin/brew" ]; then
    export BREW_PREFIX="$__brew"
    eval "$("$__brew/bin/brew" shellenv)"
    break
  fi
done
unset __brew
: "${BREW_PREFIX:=/opt/homebrew}"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# Empty on purpose: the prompt is starship (~/.config/starship.toml), set up at the bottom.
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export PATH="$BREW_PREFIX/opt/mongodb-community@5.0/bin:$PATH"

export PATH="$BREW_PREFIX/opt/libpq/bin:$PATH"

alias cnvim="cd $HOME/.config/nvim && nvim ."

# bindkey -s ^f  "$HOME/.dotfiles/tab-navigator.sh\n"

alias python="python3"
alias orbit="cd $HOME/personal/orbit/ && make dev"

command -v go >/dev/null && export PATH="$PATH:$(go env GOPATH)/bin"

alias vim="nvim"
alias lg="lazygit"

export PATH=$PATH:$HOME/Library/Python/3.14/bin

export PATH="/usr/local/opt/libpq/bin:$PATH"

alias db="PGPASSWORD=postgres psql -h localhost -U postgres -d pos"


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null
# END opam configuration
#






# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$BREW_PREFIX/bin:$PATH"




[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh
export PATH="$BREW_PREFIX/opt/llvm/bin:$PATH"


export PATH="$HOME/.local/bin:$PATH"


# Kitty icat alias
alias icat="kitty +kitten icat"

# Kitty power tools (kittens)
alias hg="kitten hyperlinked-grep"     # ripgrep with jump-to-line in editor
alias ssh="kitten ssh"                 # full kitty features over SSH
alias push="kitten transfer --direction=upload"    # upload to remote/container
alias pull="kitten transfer --direction=download"  # pull from remote/container
alias rfile="kitten remote-file"       # edit remote/container files in local editor
alias kdiff="kitten diff"              # visual diff for images/PDFs/text
alias kclip="kitten clipboard"         # clipboard history with filters



# Sessionizer — Ctrl+F to launch
sessionizer() {
  tv sessionizer
}
bindkey -s '^f' 'sessionizer\n'   # zsh
# For bash: bind -x '"\C-f": sessionizer'

# Added by Antigravity IDE
export PATH="$HOME/.antigravity-ide/antigravity-ide/bin:$PATH"

# >>> BridgeSpace shell integration >>>
# BridgeSpace emits OSC 133 semantic prompt markers so its AI inline
# autocomplete can tell when you are typing vs when a command is
# running. Safe to delete this block — it only adds precmd/preexec
# hooks. Unset BRIDGESPACE_SHELL_INTEGRATION to disable at runtime.
if [[ -o interactive && "${BRIDGESPACE_SHELL_INTEGRATION:-1}" != "0" ]]; then
  __bridgespace_prompt_start() { printf '\e]133;A\a'; }
  __bridgespace_command_start() { printf '\e]133;C\a'; }
  autoload -Uz add-zsh-hook 2>/dev/null
  if (( ${+functions[add-zsh-hook]} )); then
    add-zsh-hook precmd __bridgespace_prompt_start 2>/dev/null
    add-zsh-hook preexec __bridgespace_command_start 2>/dev/null
  fi
fi
# <<< BridgeSpace shell integration <<<

# kimi-code
export PATH="$HOME/.kimi-code/bin:$PATH"

# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh $fpath)
autoload -Uz compinit && compinit -C
# <<< grok installer <<<

# ═══════════════════ carried over from nushell ══════════════════

export EDITOR="nvim"
export VISUAL="nvim"
export BAT_THEME="Catppuccin Mocha"
export LS_COLORS="di=1;38;2;137;180;250:ln=38;2;148;226;213:ex=1;38;2;166;227;161:fi=38;2;205;214;244:or=38;2;243;139;168:pi=38;2;250;179;135:so=38;2;203;166;247:bd=38;2;249;226;175:cd=38;2;249;226;175:*.md=38;2;249;226;175:*.json=38;2;249;226;175:*.toml=38;2;249;226;175:*.yaml=38;2;249;226;175:*.yml=38;2;249;226;175:*.lock=38;2;108;112;134:*.log=38;2;108;112;134:*.zip=38;2;245;194;231:*.tar=38;2;245;194;231:*.gz=38;2;245;194;231:*.png=38;2;203;166;247:*.jpg=38;2;203;166;247:*.svg=38;2;203;166;247:*.pdf=38;2;235;160;172"
export EZA_COLORS="da=38;2;127;132;156:uu=38;2;166;227;161:gu=38;2;148;226;213:sn=38;2;137;220;235:sb=38;2;137;220;235"

alias ll="eza -l  --icons=always --group-directories-first --git --time-style=relative"
alias la="eza -la --icons=always --group-directories-first --git --time-style=relative"
alias lt="eza --tree --level=2 --icons=always --group-directories-first"
alias cat="bat --style=plain"
# oh-my-zsh's git plugin makes gl `git pull`; this keeps the log meaning used in nu.
alias gl="git log --oneline --graph --decorate -20"
alias ports="lsof -iTCP -sTCP:LISTEN -P -n"

# ──────────────────────── fzf key bindings ──────────────────────
#   ctrl-t  insert a file path   ·   alt-c  jump to a directory
export FZF_DEFAULT_OPTS="--color=bg+:#313244,bg:-1,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 --color=selected-bg:#45475a,border:#585b70 --layout=reverse --border=rounded --info=inline"
export FZF_CTRL_T_COMMAND="fd --type f --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--height 45% --prompt='  ' --preview 'bat --style=numbers --color=always --line-range :200 {}'"
export FZF_ALT_C_COMMAND="fd --type d --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_OPTS="--height 45% --prompt='  ' --preview 'eza --tree --level=2 --color=always --icons=always {}'"
command -v fzf >/dev/null && source <(fzf --zsh)

# ─────────────────────────── git helpers ────────────────────────
# Delete local branches that are finished (base branches, current branch and release/* are kept):
#   merged — merged into dev/develop/staging/main/master on origin
#   gone   — was pushed, and its remote branch has since been deleted (squash-merged PRs)
# oh-my-zsh's git plugin defines gclean as `git clean -id`; drop it so this function wins.
unalias gclean 2>/dev/null
gclean() {
  local -a base_names bases keep candidates
  local b
  base_names=(dev develop staging main master)
  git fetch --prune --quiet || return
  keep=($base_names "$(git branch --show-current)")
  for b in $base_names; do
    git rev-parse --verify --quiet "origin/$b" >/dev/null && bases+=("origin/$b")
  done
  candidates=(${(f)"$(
    {
      for b in $bases; do git branch --format='%(refname:short)' --merged "$b"; done
      git for-each-ref refs/heads --format='%(refname:short)|%(upstream:track)' | awk -F'|' '$2 == "[gone]" { print $1 }'
    } | sort -u
  )"})
  candidates=(${candidates:|keep})
  candidates=(${candidates:#release/*})
  if (( ! $#candidates )); then
    echo "nothing to clean"
    return
  fi
  print -l $candidates
  if read -q "?delete $#candidates local branches? [y/N] "; then
    echo
    git branch -D $candidates
  else
    echo
  fi
}

# ─────────────────────────── processes ──────────────────────────
# Pick processes with fzf (tab for multiple) and kill them:  killp node   ·   killp -f node
killp() {
  local sig=TERM picked pid
  if [[ $1 == -f || $1 == --force ]]; then sig=KILL; shift; fi
  # Plain substring match on the process name (not a regex), case-insensitive.
  picked=$(ps -Arco pid,%cpu,rss,comm | awk -v n="${(L)1}" 'NR > 1 {
    name = $0; sub(/^ *[0-9]+ +[0-9.]+ +[0-9]+ +/, "", name)
    if (index(tolower(name), n)) print
  }')
  if [[ -z $picked ]]; then
    echo "no process matching '$1'"
    return 1
  fi
  picked=$(fzf --multi --header "pid  cpu  mem(KB)  name   (tab: select multiple)" <<< $picked) || return
  for pid in ${(f)"$(awk '{ print $1 }' <<< $picked)"}; do
    kill -$sig $pid && echo "killed $pid"
  done
}

# ─────────────────────────── bookorbit ──────────────────────────
# Self-hosted reading tracker in ~/personal/bookorbit (docker compose).
#   bookorbit · bookorbit stop · bookorbit update · bookorbit logs
_bookorbit_compose() { docker compose --project-directory "$HOME/personal/bookorbit" "$@" }
_bookorbit_up() { [[ $(curl -s -o /dev/null -w '%{http_code}' http://localhost:3000) == 200 ]] }

# Retry a check command every second until it succeeds or 90s pass.
_bookorbit_wait() {
  local what=$1 deadline=$(( SECONDS + 90 ))
  shift
  until "$@" >/dev/null 2>&1; do
    if (( SECONDS > deadline )); then
      echo "$what not ready after 90s" >&2
      return 1
    fi
    sleep 1
  done
}

bookorbit() {
  case $1 in
    stop)   _bookorbit_compose down ;;
    update) _bookorbit_compose pull && _bookorbit_compose up -d ;;
    logs)   _bookorbit_compose logs -f --tail 100 app ;;
    "")
      # Start OrbStack + containers if needed, wait until the app answers, open it in the browser
      if ! docker info >/dev/null 2>&1; then
        echo "starting OrbStack…"
        open -a OrbStack
        _bookorbit_wait docker docker info || return
      fi
      _bookorbit_compose up -d || return
      _bookorbit_wait bookorbit _bookorbit_up || return
      open http://localhost:3000
      ;;
    *) echo "usage: bookorbit [stop|update|logs]" >&2; return 1 ;;
  esac
}

# ════════════════════════ INTEGRATIONS ══════════════════════════
#   zoxide   → `z <frecent dir>` / `zi` fuzzy jump
#   atuin    → ctrl-r fullscreen history search (up-arrow unchanged); loaded after fzf so it owns ctrl-r
#   starship → prompt
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
command -v atuin >/dev/null && eval "$(atuin init zsh --disable-up-arrow)"
command -v starship >/dev/null && eval "$(starship init zsh)"
