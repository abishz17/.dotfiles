-- grug-far: project-wide find & replace in an editable buffer (ripgrep under the hood)
vim.pack.add({ 'https://github.com/MagicDuck/grug-far.nvim' })

vim.keymap.set("n", "<leader>fr", function()
  require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = "Find & replace (project)" })

vim.keymap.set("x", "<leader>fr", function()
  require("grug-far").with_visual_selection()
end, { desc = "Find & replace selection (project)" })
