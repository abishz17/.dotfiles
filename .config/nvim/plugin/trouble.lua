-- Trouble.nvim: lazy load on first keymap use
local function load_trouble()
  vim.pack.add({ 'https://github.com/folke/trouble.nvim' })
  require("trouble").setup({})
end

local function trouble_cmd(cmd)
  return function()
    load_trouble()
    vim.cmd(cmd)
  end
end

vim.keymap.set("n", "<leader>xx", trouble_cmd("Trouble diagnostics toggle"), { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", trouble_cmd("Trouble diagnostics toggle filter.buf=0"), { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xs", trouble_cmd("Trouble symbols toggle focus=false"), { desc = "Symbols (Trouble)" })
vim.keymap.set("n", "<leader>xl", trouble_cmd("Trouble lsp toggle focus=false win.position=right"), { desc = "LSP Definitions / References (Trouble)" })
vim.keymap.set("n", "<leader>xL", trouble_cmd("Trouble loclist toggle"), { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", trouble_cmd("Trouble qflist toggle"), { desc = "Quickfix List (Trouble)" })
