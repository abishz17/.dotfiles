vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    vim.pack.add('https://github.com/kylechui/nvim-surround')
    require("nvim-surround").setup({})
  end,
})
