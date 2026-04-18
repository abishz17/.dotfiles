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
  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = false,  -- don't fall back to LSP, use formatters only
  },
})

vim.keymap.set("n", "<leader>f", function()
  require("conform").format({ async = true })
end, {})
