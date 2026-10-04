vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.g.mapleader = " "
vim.opt.guicursor = "n-v-i-c:block-Cursor"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"
vim.opt.smartindent = true
vim.opt.undofile = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.updatetime = 250
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.inccommand = "split" -- :s preview window lists off-screen matches too
vim.opt.winborder = "rounded" -- borders on all floats (hover, signature, diagnostics)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- fold by treesitter blocks (fns, impls, ...)
vim.opt.foldtext = "" -- folded line keeps its syntax colors
vim.opt.foldlevel = 99 -- open files with everything unfolded

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 1

vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

vim.keymap.set("n", "<leader>U", function()
  if not package.loaded["undotree"] then
    vim.cmd.packadd("nvim.undotree")
  end
  require("undotree").open() -- toggles: closes if already open
end, { desc = "Toggle undotree" })


vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", { silent = true })

vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { silent = true })



vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
  end,
})



vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd({ "FocusGained" }, {
  callback = function()
    if vim.o.autoread then
      vim.cmd("checktime")
    end
  end,
})
