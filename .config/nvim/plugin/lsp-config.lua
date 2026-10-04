vim.pack.add({
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/neovim/nvim-lspconfig',
})

-- Mason handles PATH + ensures servers are installed.
-- automatic_enable=false: we control which servers start.
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls", "gopls", "pyright", "clangd",
    "ts_ls", "tailwindcss", "bashls",
  },
  automatic_enable = false,
})

-- Global capabilities for all servers (merges with per-server defaults)
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities({
    textDocument = { completion = { completionItem = { snippetSupport = false } } },
  }),
})

-- Only override servers whose config differs from the nvim-lspconfig default
vim.lsp.config("tailwindcss", {
  root_dir = function(fname)
    local util = require("lspconfig.util")
    return util.root_pattern(
      "tailwind.config.js", "tailwind.config.ts",
      "tailwind.config.cjs", "tailwind.config.mjs"
    )(fname)
  end,
})

vim.lsp.config("clangd", {
  cmd = (function()
    local cwd = vim.fn.getcwd()
    if string.match(cwd, "control%-engine") then
      return { "/Users/abish/.local/bin/control-engine-clang-setup.sh" }
    end
    return { "clangd", "--background-index" }
  end)(),
})

vim.lsp.config("gopls", {
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = { unusedparams = true },
    },
  },
})

-- Enable the servers you actually want
for _, name in ipairs({ "lua_ls", "tailwindcss", "pyright", "bashls", "clangd", "gopls", "ts_ls", "ocamllsp" }) do
  vim.lsp.enable(name)
end

-- Suppress servers you don't want (nvim-lspconfig ships many)
vim.lsp.enable("angularls", false)
vim.lsp.enable("rust_analyzer", false)

-- LSP keymaps
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
