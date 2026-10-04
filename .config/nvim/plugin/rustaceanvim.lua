vim.pack.add({
  { src = 'https://github.com/mrcjkb/rustaceanvim', version = vim.version.range('9.x') },
})

vim.g.rustaceanvim = {
  server = {
    on_attach = function(_, bufnr)
      local map = function(lhs, cmd, desc)
        vim.keymap.set("n", lhs, function() vim.cmd.RustLsp(cmd) end, { buffer = bufnr, desc = desc })
      end
      map("K", { "hover", "actions" }, "Rust hover actions")
      map("<leader>rd", "renderDiagnostic", "Rust full diagnostic (cargo style)")
      map("<leader>re", "explainError", "Rust explain error code")
      map("<leader>rm", { "expandMacro", "float" }, "Rust expand macro")
      map("<leader>rr", "runnables", "Rust runnables")
      map("<leader>rt", "testables", "Rust testables")
      map("<leader>rg", "debuggables", "Rust debuggables")
      map("<leader>rc", "openCargo", "Rust open Cargo.toml")
      -- "▶ Run | Debug" above main/tests; run the one under the cursor with grx
      vim.lsp.codelens.enable(true, { bufnr = bufnr })
    end,
    default_settings = {
      ["rust-analyzer"] = {
        cargo = {
          targetDir = true,
          buildScripts = { enable = true },
        },
        check = {
          command = "clippy",
          workspace = false,
          extraArgs = { "--no-deps" },
        },
        diagnostics = {
          enable = true,
          -- live (no-save) type-mismatch etc. checks; may show the odd false positive
          experimental = { enable = true },
          styleLints = { enable = false },
        },
        files = {
          exclude = { "target", ".git" },
        },
        procMacro = {
          enable = true,
        },
        lru = {
          capacity = 256,
        },
        cachePriming = {
          enable = true,
          numThreads = "physical",
        },
        inlayHints = {
          chainingHints = { enable = true },
          parameterHints = { enable = true },
          typeHints = { enable = true },
          closingBraceHints = {
            enable = true,
            minLines = 20,
          },
          maxLength = 30,
        },
      },
    },
  },
}

-- Style rust-analyzer's semantic token modifiers (needs type info, so treesitter can't do it).
-- Re-applied on ColorScheme because :colorscheme clears custom highlights.
local function rust_semantic_hl()
  local err = vim.api.nvim_get_hl(0, { name = "DiagnosticError", link = false }).fg
  vim.api.nvim_set_hl(0, "@lsp.mod.mutable.rust", { underline = true })
  vim.api.nvim_set_hl(0, "@lsp.mod.unsafe.rust", { fg = err, bold = true })
  vim.api.nvim_set_hl(0, "@lsp.mod.consuming.rust", { italic = true })
end
vim.api.nvim_create_autocmd("ColorScheme", { callback = rust_semantic_hl })
rust_semantic_hl()

-- Guide line at rustfmt's default max_width
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function() vim.opt_local.colorcolumn = "100" end,
})
