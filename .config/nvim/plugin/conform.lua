vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })

require("conform").setup({
  formatters_by_ft = {
    python = { "black", "isort" },
    go = { "gofumpt", "goimports" },
    ocaml = { "ocamlformat" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    rust = { "rustfmt" },  -- direct rustfmt, not via rust-analyzer
  },
  format_after_save = {
    lsp_fallback = false,  -- don't fall back to LSP, use formatters only
  },
})

