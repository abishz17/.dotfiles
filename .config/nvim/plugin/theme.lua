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
	-- Colors are rose-pine palette names (rose, foam, iris, muted, highlight_low, ...)
	highlight_groups = {
		Normal = { bg = "NONE" }, -- let kitty's background show through
		NormalFloat = { bg = "NONE" },
		CursorLineNr = { fg = "rose", bold = true }, -- current line number in the accent color
		Folded = { bg = "highlight_low" }, -- faint band marks a folded line
		FloatBorder = { fg = "highlight_high", bg = "NONE" }, -- softer popup/completion borders
		PmenuSel = { bg = "highlight_med", bold = true }, -- selected completion item
	},
})
vim.cmd("colorscheme rose-pine")
