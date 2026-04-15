-- Neovim Tips
vim.pack.add({
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/saxon1964/neovim-tips',
})

require("neovim_tips").setup({
  daily_tip = 0,
  bookmark_symbol = "🌟 ",
})

vim.keymap.set("n", "<leader>nto", ":NeovimTips<CR>", { desc = "Neovim tips" })
vim.keymap.set("n", "<leader>ntr", ":NeovimTipsRandom<CR>", { desc = "Show random tip" })
vim.keymap.set("n", "<leader>nte", ":NeovimTipsEdit<CR>", { desc = "Edit your tips" })
vim.keymap.set("n", "<leader>nta", ":NeovimTipsAdd<CR>", { desc = "Add your tip" })
vim.keymap.set("n", "<leader>ntp", ":NeovimTipsPdf<CR>", { desc = "Open tips PDF" })
