-- Neovim Tips (lazy: loads on first use of any tips command)
local function load_tips()
  vim.pack.add({
    'https://github.com/MunifTanjim/nui.nvim',
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
    'https://github.com/saxon1964/neovim-tips',
  })
  require("neovim_tips").setup({
    daily_tip = 0,
    bookmark_symbol = "🌟 ",
  })
end

local function lazy_cmd(cmd)
  return function()
    load_tips()
    vim.cmd(cmd)
  end
end

vim.keymap.set("n", "<leader>nto", lazy_cmd("NeovimTips"), { desc = "Neovim tips" })
vim.keymap.set("n", "<leader>ntr", lazy_cmd("NeovimTipsRandom"), { desc = "Show random tip" })
vim.keymap.set("n", "<leader>nte", lazy_cmd("NeovimTipsEdit"), { desc = "Edit your tips" })
vim.keymap.set("n", "<leader>nta", lazy_cmd("NeovimTipsAdd"), { desc = "Add your tip" })
vim.keymap.set("n", "<leader>ntp", lazy_cmd("NeovimTipsPdf"), { desc = "Open tips PDF" })
