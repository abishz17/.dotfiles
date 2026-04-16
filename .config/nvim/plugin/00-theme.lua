vim.pack.add({
  { src = 'https://github.com/vague-theme/vague.nvim', name = 'vague' },
})

require("vague").setup({
  transparent = false,
  bold = true,
  italic = true,
})

vim.cmd("colorscheme vague")
