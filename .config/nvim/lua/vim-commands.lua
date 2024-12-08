vim.cmd("set expandtab")
vim.cmd("set shiftwidth=2")
vim.cmd("set softtabstop=2")
vim.cmd("set tabstop=2")
vim.g.mapleader = " "
vim.opt.guicursor = "n-v-i-c:block-Cursor"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"
vim.opt.smartindent = true
vim.cmd("set nowrap")
vim.keymap.set('n', '<C-S-k>', '<cmd>m -2<CR>')
vim.keymap.set('n', '<C-S-j>', '<cmd>m +1<CR>')
