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

-- vim.pack.add({
-- 	{
-- 		src = "https://github.com/rose-pine/neovim",
-- 		name = "rose-pine",
-- 	},
-- })
-- -- Use the same variant as kitty (Rosé Pine Moon) so the palette matches
-- -- exactly, and let the terminal background show through so there's no seam.
-- require("rose-pine").setup({
-- 	variant = "moon",
-- 	-- Colors are rose-pine palette names (rose, foam, iris, muted, highlight_low, ...)
-- 	highlight_groups = {
-- 		Normal = { bg = "NONE" }, -- let kitty's background show through
-- 		NormalFloat = { bg = "NONE" },
-- 		CursorLineNr = { fg = "rose", bold = true }, -- current line number in the accent color
-- 		Folded = { bg = "highlight_low" }, -- faint band marks a folded line
-- 		FloatBorder = { fg = "highlight_high", bg = "NONE" }, -- softer popup/completion borders
-- 		PmenuSel = { bg = "highlight_med", bold = true }, -- selected completion item
-- 	},
-- })
-- vim.cmd("colorscheme rose-pine")

vim.pack.add({ "https://github.com/rebelot/kanagawa.nvim" })

require("kanagawa").setup({
	colors = {
		theme = {
			wave = { ui = { bg = "#14181d" } }, -- darker, cooler background to match the reference look
			all = { ui = { bg_gutter = "none" } }, -- line number column blends into the background
		},
	},
	overrides = function(colors)
		local palette = colors.palette
		return {
			NormalFloat = { bg = "none" },
			FloatBorder = { bg = "none" }, -- softer popup/completion borders
			FloatTitle = { bg = "none" },
			CursorLineNr = { fg = palette.sakuraPink, bold = true }, -- current line number in the accent color
		}
	end,
})
vim.cmd("colorscheme kanagawa-wave")
