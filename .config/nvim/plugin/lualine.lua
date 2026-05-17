vim.pack.add({
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
})

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    require('lualine').setup({})
  end,
})
