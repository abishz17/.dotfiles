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
vim.opt.undofile = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.updatetime = 250
vim.opt.ignorecase = true
vim.cmd("set nowrap")
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set('n', '<leader>ot', '<cmd>OverseerToggle<cr>', { desc = 'Toggle Overseer' })
vim.keymap.set('n', '<leader>or', '<cmd>OverseerRun<cr>', { desc = 'Run Task' })
vim.keymap.set('n', '<leader>oa', '<cmd>OverseerQuickAction<cr>', { desc = 'Task Action' })



vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", { silent = true })

vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { silent = true })



vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})


