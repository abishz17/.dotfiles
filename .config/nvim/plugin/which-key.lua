-- which-key: after <leader> (or g, [, ], etc.) a popup lists the next keys, using each keymap's desc
vim.schedule(function()
  vim.pack.add({ 'https://github.com/folke/which-key.nvim' })
  local wk = require("which-key")
  wk.setup({ preset = "modern" })
  wk.add({
    { "<leader>a", group = "opencode" },
    { "<leader>b", group = "buffer" },
    { "<leader>c", group = "code" },
    { "<leader>d", group = "debug" },
    { "<leader>f", group = "find" },
    { "<leader>g", group = "git" },
    { "<leader>n", group = "notifications/tips" },
    { "<leader>r", group = "rust/rename" },
    { "<leader>u", group = "ui toggles" },
    { "<leader>x", group = "trouble" },
  })
end)
