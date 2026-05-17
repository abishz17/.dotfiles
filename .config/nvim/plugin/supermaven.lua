-- Supermaven (AI completion, lazy: loads on first InsertEnter)
vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    vim.pack.add({ 'https://github.com/supermaven-inc/supermaven-nvim' })
    require("supermaven-nvim").setup({})
  end,
})
