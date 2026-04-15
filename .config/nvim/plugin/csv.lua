-- Data Viewer (CSV)
vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/kkharji/sqlite.lua',
  'https://github.com/vidocqh/data-viewer.nvim',
})
require("data-viewer").setup()
