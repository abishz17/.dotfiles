# ═══════════════════════════════════════════════════════════════
#  config.nu — Nushell 0.115  ·  Catppuccin Mocha
#
#  Integrations (zoxide / carapace / atuin) live in ./integrations/
#  and are sourced at the bottom of this file.
#  The prompt itself lives in ~/.config/starship.toml
#
#  Regenerate the integration files after upgrading a tool:
#    zoxide init nushell   | save -f integrations/zoxide.nu
#    carapace _carapace nushell | save -f integrations/carapace.nu
#    atuin init nu --disable-up-arrow | save -f integrations/atuin.nu
# ═══════════════════════════════════════════════════════════════

# ───────────────────────────────── PATH ─────────────────────────
$env.PATH = ($env.PATH | prepend "/opt/homebrew/bin")
$env.PATH = ($env.PATH | prepend $"($env.HOME)/.npm-global/bin")
$env.PATH = ($env.PATH | prepend $"($env.HOME)/.local/bin")
$env.PATH = ($env.PATH | prepend $"($env.HOME)/.bun/bin")

$env.EDITOR = "nvim"
$env.VISUAL = "nvim"
$env.BAT_THEME = "Catppuccin Mocha"

# ───────────────────────────── palette ──────────────────────────
let mocha = {
    rosewater: "#f5e0dc"
    flamingo:  "#f2cdcd"
    pink:      "#f5c2e7"
    mauve:     "#cba6f7"
    red:       "#f38ba8"
    maroon:    "#eba0ac"
    peach:     "#fab387"
    yellow:    "#f9e2af"
    green:     "#a6e3a1"
    teal:      "#94e2d5"
    sky:       "#89dceb"
    sapphire:  "#74c7ec"
    blue:      "#89b4fa"
    lavender:  "#b4befe"
    text:      "#cdd6f4"
    subtext1:  "#bac2de"
    subtext0:  "#a6adc8"
    overlay2:  "#9399b2"
    overlay1:  "#7f849c"
    overlay0:  "#6c7086"
    surface2:  "#585b70"
    surface1:  "#45475a"
    surface0:  "#313244"
    base:      "#1e1e2e"
    mantle:    "#181825"
    crust:     "#11111b"
}

# ─────────────────────── syntax & data colors ───────────────────
$env.config.color_config = {
    separator: $mocha.surface2
    leading_trailing_space_bg: { attr: "n" }
    header: { fg: $mocha.green attr: "b" }
    empty: $mocha.blue
    bool: $mocha.peach
    int: $mocha.text
    filesize: $mocha.sky
    duration: $mocha.text
    date: $mocha.mauve
    range: $mocha.text
    float: $mocha.text
    string: $mocha.text
    nothing: $mocha.red
    binary: $mocha.text
    cell-path: $mocha.text
    row_index: { fg: $mocha.mauve attr: "b" }
    record: $mocha.text
    list: $mocha.text
    closure: $mocha.green
    glob: $mocha.teal
    block: $mocha.text
    hints: $mocha.overlay0
    search_result: { fg: $mocha.base bg: $mocha.yellow }

    shape_and: { fg: $mocha.pink attr: "b" }
    shape_binary: { fg: $mocha.pink attr: "b" }
    shape_block: { fg: $mocha.blue attr: "b" }
    shape_bool: $mocha.teal
    shape_closure: { fg: $mocha.green attr: "b" }
    shape_custom: $mocha.green
    shape_datetime: { fg: $mocha.teal attr: "b" }
    shape_directory: $mocha.teal
    shape_external: $mocha.teal
    shape_external_resolved: $mocha.teal
    shape_externalarg: { fg: $mocha.green attr: "b" }
    shape_filepath: $mocha.teal
    shape_flag: { fg: $mocha.blue attr: "b" }
    shape_float: { fg: $mocha.pink attr: "b" }
    shape_garbage: { fg: $mocha.text bg: $mocha.red attr: "b" }
    shape_glob_interpolation: { fg: $mocha.teal attr: "b" }
    shape_globpattern: { fg: $mocha.teal attr: "b" }
    shape_int: { fg: $mocha.mauve attr: "b" }
    shape_internalcall: { fg: $mocha.teal attr: "b" }
    shape_keyword: { fg: $mocha.mauve attr: "b" }
    shape_list: { fg: $mocha.teal attr: "b" }
    shape_literal: $mocha.blue
    shape_match_pattern: $mocha.green
    shape_matching_brackets: { attr: "u" }
    shape_nothing: $mocha.teal
    shape_operator: $mocha.peach
    shape_or: { fg: $mocha.pink attr: "b" }
    shape_pipe: { fg: $mocha.pink attr: "b" }
    shape_range: { fg: $mocha.yellow attr: "b" }
    shape_raw_string: { fg: $mocha.text attr: "b" }
    shape_record: { fg: $mocha.teal attr: "b" }
    shape_redirection: { fg: $mocha.pink attr: "b" }
    shape_signature: { fg: $mocha.green attr: "b" }
    shape_string: $mocha.green
    shape_string_interpolation: { fg: $mocha.teal attr: "b" }
    shape_table: { fg: $mocha.blue attr: "b" }
    shape_vardecl: { fg: $mocha.blue attr: "u" }
    shape_variable: $mocha.pink
}

# ───────────────────────── dropdown menus ───────────────────────
$env.config.menus = ($env.config.menus | each {|menu|
    if $menu.name in ["completion_menu" "history_menu" "help_menu" "ide_completion_menu" "vars_menu" "commands_menu"] {
        $menu | upsert style {
            text: $mocha.text
            selected_text: { fg: $mocha.crust bg: $mocha.mauve attr: "b" }
            description_text: $mocha.overlay1
            match_text: { fg: $mocha.green attr: "b" }
            selected_match_text: { fg: $mocha.crust bg: $mocha.green attr: "b" }
        }
    } else { $menu }
})

# ───────────────────────────── tables ───────────────────────────
$env.config.table.mode = "rounded"
$env.config.table.header_on_separator = true
$env.config.table.index_mode = "auto"
$env.config.table.padding = { left: 1, right: 1 }
$env.config.footer_mode = 25
$env.config.float_precision = 2
$env.config.datetime_format.table = "%b %d %H:%M"

# ───────────────────── editing & line editor ────────────────────
$env.config.show_banner = false
$env.config.edit_mode = "emacs"
$env.config.error_style = "fancy"
$env.config.display_errors.exit_code = false
$env.config.highlight_resolved_externals = true
$env.config.rm.always_trash = true
$env.config.cursor_shape = {
    emacs: line
    vi_insert: line
    vi_normal: block
}

# ──────────────────── terminal integration (OSC) ────────────────
$env.config.shell_integration.osc2 = true
$env.config.shell_integration.osc7 = true
$env.config.shell_integration.osc8 = true
$env.config.shell_integration.osc133 = true
$env.config.shell_integration.osc633 = true
$env.config.shell_integration.reset_application_mode = true

# ──────────────────────────── history ───────────────────────────
$env.config.history.max_size = 100_000
$env.config.history.file_format = "sqlite"
$env.config.history.isolation = false

# ────────────────────────── completions ─────────────────────────
# NOTE: `completions.external.completer` is intentionally left unset —
# integrations/carapace.nu fills it in only when it is still null.
$env.config.completions.algorithm = "fuzzy"
$env.config.completions.sort = "smart"
$env.config.completions.case_sensitive = false
$env.config.completions.quick = true
$env.config.completions.partial = true
$env.config.completions.external.enable = true

# ────────────────────────── file colors ─────────────────────────
$env.config.ls.use_ls_colors = true
$env.LS_COLORS = ([
    "di=1;38;2;137;180;250"      # directories  → blue
    "ln=38;2;148;226;213"        # symlinks     → teal
    "ex=1;38;2;166;227;161"      # executables  → green
    "fi=38;2;205;214;244"        # files        → text
    "or=38;2;243;139;168"        # broken link  → red
    "pi=38;2;250;179;135"
    "so=38;2;203;166;247"
    "bd=38;2;249;226;175"
    "cd=38;2;249;226;175"
    "*.md=38;2;249;226;175"
    "*.json=38;2;249;226;175"
    "*.toml=38;2;249;226;175"
    "*.yaml=38;2;249;226;175"
    "*.yml=38;2;249;226;175"
    "*.lock=38;2;108;112;134"
    "*.log=38;2;108;112;134"
    "*.zip=38;2;245;194;231"
    "*.tar=38;2;245;194;231"
    "*.gz=38;2;245;194;231"
    "*.png=38;2;203;166;247"
    "*.jpg=38;2;203;166;247"
    "*.svg=38;2;203;166;247"
    "*.pdf=38;2;235;160;172"
] | str join ":")

$env.EZA_COLORS = "da=38;2;127;132;156:uu=38;2;166;227;161:gu=38;2;148;226;213:sn=38;2;137;220;235:sb=38;2;137;220;235"

# ─────────────────────────── sessionizer ────────────────────────
# ctrl-f → television `sessionizer` channel (~, ~/personal, ~/work).
#   enter  open/focus a kitty tab  ·  ctrl-o  opencode tab  ·  ctrl-s  tab + opencode split
def sessionizer [] {
    tv sessionizer
}

# ──────────────────────── fzf key bindings ──────────────────────
#   ctrl-t  insert a file path   ·   alt-c  jump to a directory
$env.config.keybindings = ($env.config.keybindings | append [
    {
        name: sessionizer
        modifier: control
        keycode: char_f
        mode: [emacs vi_normal vi_insert]
        event: { send: executehostcommand, cmd: "sessionizer" }
    }
    {
        name: fzf_file
        modifier: control
        keycode: char_t
        mode: [emacs vi_normal vi_insert]
        event: {
            send: executehostcommand
            cmd: "let f = (fd --type f --hidden --strip-cwd-prefix --exclude .git | fzf --height 45% --reverse --border=rounded --prompt='  ' --preview 'bat --style=numbers --color=always --line-range :200 {}' | str trim); if ($f | is-not-empty) { commandline edit --insert $f }"
        }
    }
    {
        name: fzf_dir
        modifier: alt
        keycode: char_c
        mode: [emacs vi_normal vi_insert]
        event: {
            send: executehostcommand
            cmd: "let d = (fd --type d --hidden --strip-cwd-prefix --exclude .git | fzf --height 45% --reverse --border=rounded --prompt='  ' --preview 'eza --tree --level=2 --color=always --icons=always {}' | str trim); if ($d | is-not-empty) { cd $d }"
        }
    }
])

$env.FZF_DEFAULT_OPTS = ([
    "--color=bg+:#313244,bg:-1,spinner:#f5e0dc,hl:#f38ba8"
    "--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc"
    "--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
    "--color=selected-bg:#45475a,border:#585b70"
    "--layout=reverse --border=rounded --info=inline"
] | str join " ")

# ─────────────────────────── aliases ────────────────────────────
# `ls` stays Nushell's structured builtin on purpose — piping
# `ls | where size > 1mb` is the whole point of this shell.
alias ll = eza -l   --icons=always --group-directories-first --git --time-style=relative
alias la = eza -la  --icons=always --group-directories-first --git --time-style=relative
alias lt = eza --tree --level=2 --icons=always --group-directories-first
alias cat = bat --style=plain

alias vim = nvim
alias opencode = opencode2
alias gd = git diff
alias gst = git status
alias gl = git log --oneline --graph --decorate -20
alias lg = lazygit

# ═══════════════════════════ PROMPT ═════════════════════════════
$env.STARSHIP_SHELL = "nu"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_MULTILINE_INDICATOR = $"(ansi -e '38;2;88;91;112m')│(ansi reset) "

# Transient prompt: once a command has run, the tall rail collapses to
# a dim path + ❯ so scrollback stays readable. Delete this block to
# keep the full prompt in history instead.
$env.TRANSIENT_PROMPT_COMMAND = {||
    let dir = (pwd | str replace $nu.home-dir "~")
    $"(ansi -e '38;2;108;112;134m')($dir)(ansi reset) (ansi -e '1;38;2;166;227;161m')❯(ansi reset) "
}
$env.TRANSIENT_PROMPT_COMMAND_RIGHT = ""
$env.TRANSIENT_PROMPT_INDICATOR = ""
$env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = ""
$env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = ""
$env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = ""

# ════════════════════════ INTEGRATIONS ══════════════════════════
#   carapace → completions for 600+ commands
#   zoxide   → `z <frecent dir>` / `zi` fuzzy jump
#   atuin    → ctrl-r fullscreen history search (up-arrow unchanged)
const integrations = ($nu.default-config-dir | path join "integrations")

source ($integrations | path join "carapace.nu")
source ($integrations | path join "zoxide.nu")
source ($integrations | path join "atuin.nu")
