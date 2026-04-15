-- nvim-surround (Lua rewrite of vim-surround: dot-repeatable, treesitter-aware)
-- Same keybinds: ys (add), cs (change), ds (delete)
vim.pack.add({ 'https://github.com/kylechui/nvim-surround' })
require("nvim-surround").setup()
