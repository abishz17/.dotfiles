vim.api.nvim_create_autocmd('WinLeave', { once = true, callback = function()
  vim.pack.add({ 'https://github.com/nvim-zh/colorful-winsep.nvim' })
  require("colorful-winsep").setup()
end })
