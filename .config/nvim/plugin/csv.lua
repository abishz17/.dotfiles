-- Data viewer with sqlite (lazy: only loads when a CSV/DB file is opened)
vim.api.nvim_create_autocmd("BufRead", {
  pattern = { "*.csv", "*.db", "*.sqlite", "*.sqlite3" },
  once = true,
  callback = function()
    vim.pack.add({
      'https://github.com/nvim-lua/plenary.nvim',
      'https://github.com/kkharji/sqlite.lua',
      'https://github.com/vidocqh/data-viewer.nvim',
    })
    require("data-viewer").setup()
  end,
})
