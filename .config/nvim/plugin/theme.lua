-- vim.pack.add({
--   { src = 'https://github.com/vague-theme/vague.nvim', name = 'vague' },
-- })
--
-- require("vague").setup({
--   transparent = false,
--   bold = true,
--   italic = true,
-- })
--
-- vim.cmd("colorscheme vague")

vim.pack.add({
	{
		src = "https://github.com/rose-pine/neovim",
		name = "rose-pine",
	},
})
require("rose-pine").setup()
vim.cmd("colorscheme rose-pine")
