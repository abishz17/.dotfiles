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
-- Use the same variant as kitty (Rosé Pine Moon) so the palette matches
-- exactly, and let the terminal background show through so there's no seam.
require("rose-pine").setup({
	variant = "moon",
	disable_background = true,
	disable_float_background = true,
})
vim.cmd("colorscheme rose-pine")
