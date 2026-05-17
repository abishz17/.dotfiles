-- CMake Tools (lazy: only loads when a CMakeLists.txt is opened)
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "CMakeLists.txt",
  once = true,
  callback = function()
    vim.pack.add({
      'https://github.com/nvim-lua/plenary.nvim',
      'https://github.com/Civitasv/cmake-tools.nvim',
    })
    require("cmake-tools").setup({})
  end,
})
