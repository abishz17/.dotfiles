vim.pack.add({
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/neovim/nvim-lspconfig',
})

-- Mason: only load when explicitly invoked, not at startup.
-- Use :Mason or :MasonInstall as you normally would.
vim.api.nvim_create_user_command("Mason", function(opts)
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls", "gopls", "pyright", "clangd",
      "ts_ls", "tailwindcss", "bashls",
    },
    automatic_enable = false,
  })
  -- re-invoke the real :Mason command now that it's loaded
  vim.cmd("Mason " .. opts.args)
end, { nargs = "*", desc = "Load Mason and open UI" })

-- LSP servers configured directly via native nvim 0.11 APIs.
-- No mason-lspconfig needed at runtime — servers are already installed.
local servers = {
  { "lua_ls" },
  {
    "tailwindcss",
    {
      root_dir = function(fname)
        local util = require("lspconfig.util")
        return util.root_pattern(
          "tailwind.config.js", "tailwind.config.ts",
          "tailwind.config.cjs", "tailwind.config.mjs"
        )(fname)
      end,
    },
  },
  { "pyright" },
  { "bashls" },
  {
    "clangd",
    {
      cmd = (function()
        local cwd = vim.fn.getcwd()
        if string.match(cwd, "control%-engine") then
          return { "/Users/abish/.local/bin/control-engine-clang-setup.sh" }
        end
        return { "clangd", "--background-index" }
      end)(),
    },
  },
  {
    "gopls",
    {
      cmd = { "gopls" },
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          analyses = { unusedparams = true },
        },
      },
    },
  },
  { "ts_ls" },
  { "ocamllsp" },
}

-- Wire up capabilities and enable servers after startup so blink.cmp
-- is guaranteed loaded (it sources before us, but capabilities call
-- is deferred to avoid pulling blink internals during plugin sourcing)
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  once = true,
  callback = function()
    local ok, blink = pcall(require, "blink.cmp")
    local capabilities = ok
      and blink.get_lsp_capabilities({
        textDocument = { completion = { completionItem = { snippetSupport = false } } },
      })
      or vim.lsp.protocol.make_client_capabilities()

    for _, server in ipairs(servers) do
      local name = server[1]
      local config = server[2] or {}
      config.capabilities = capabilities
      vim.lsp.config(name, config)
      vim.lsp.enable(name)
    end

    vim.lsp.enable("rust_analyzer", false)
  end,
})

-- LSP keymaps
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})
