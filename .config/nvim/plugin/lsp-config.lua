vim.pack.add({
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/neovim/nvim-lspconfig',
})

-- Mason
require("mason").setup()

-- Mason-lspconfig
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "gopls",
    "pyright",
    "clangd",
    "ts_ls",
    "tailwindcss",
    "bashls",
  },
  automatic_enable = false,
})

-- LSP servers
local capabilities = require("blink.cmp").get_lsp_capabilities({
  textDocument = { completion = { completionItem = { snippetSupport = false } } },
})

local servers = {
  { "lua_ls" },
  { "tailwindcss" },
  { "pyright" },
  { "bashls" },
  {
    "clangd",
    (function()
      local cwd = vim.fn.getcwd()
      local cmd
      if string.match(cwd, "control%-engine") then
        cmd = { "/Users/abish/.local/bin/control-engine-clang-setup.sh" }
      else
        cmd = {
          "clangd",
          "--background-index",
        }
      end

      return {
        cmd = cmd,
      }
    end)(),
  },
  {
    "gopls",
    {
      cmd = { "gopls" },
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          analyses = {
            unusedparams = true,
          },
        },
      },
    },
  },

  { "ts_ls" },
  { "ocamllsp" },
}

for _, server in ipairs(servers) do
  local name = server[1]
  local config = server[2] or {}

  config.capabilities = capabilities

  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end

-- Disable rust_analyzer here; rustaceanvim manages it
vim.lsp.enable("rust_analyzer", false)

-- LSP keymaps
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})
