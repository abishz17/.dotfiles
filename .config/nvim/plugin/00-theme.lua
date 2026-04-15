-- Rose Pine theme (loads first due to 00- prefix)
vim.pack.add({
  { src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' },
})

require("rose-pine").setup({
  variant = "auto",
  dark_variant = "main",
  dim_inactive_windows = false,
  extend_background_behind_borders = true,

  enable = {
    terminal = true,
    legacy_highlights = true,
    migrations = true,
  },

  styles = {
    bold = true,
    italic = true,
    transparency = true,
  },

  groups = {
    border = "muted",
    link = "iris",
    panel = "surface",

    error = "love",
    hint = "iris",
    info = "foam",
    note = "pine",
    todo = "rose",
    warn = "gold",

    git_add = "foam",
    git_change = "rose",
    git_delete = "love",
    git_dirty = "rose",
    git_ignore = "muted",
    git_merge = "iris",
    git_rename = "pine",
    git_stage = "iris",
    git_text = "rose",
    git_untracked = "subtle",

    headings = {
      h1 = "iris",
      h2 = "foam",
      h3 = "rose",
      h4 = "gold",
      h5 = "pine",
      h6 = "foam",
    },
  },

  highlight_groups = {
    Normal = { bg = "none" },
    NormalFloat = { bg = "none" },
    NormalNC = { bg = "none" },
    CursorLine = { bg = "none" },
    CursorColumn = { bg = "none" },
    ColorColumn = { bg = "none" },
    SignColumn = { bg = "none" },
    Folded = { bg = "none" },
    FoldColumn = { bg = "none" },
    LineNr = { bg = "none" },
    CursorLineNr = { bg = "none" },
    EndOfBuffer = { bg = "none" },

    StatusLine = { fg = "love", bg = "love", blend = 10 },
    StatusLineNC = { fg = "subtle", bg = "surface" },
    TabLine = { bg = "none" },
    TabLineFill = { bg = "none" },
    TabLineSel = { fg = "text", bg = "none" },

    Pmenu = { bg = "none" },
    PmenuSel = { bg = "overlay" },
    PmenuSbar = { bg = "none" },
    PmenuThumb = { bg = "none" },

    DiagnosticVirtualTextError = { bg = "none" },
    DiagnosticVirtualTextWarn = { bg = "none" },
    DiagnosticVirtualTextInfo = { bg = "none" },
    DiagnosticVirtualTextHint = { bg = "none" },
  },
})

vim.cmd("colorscheme rose-pine")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
