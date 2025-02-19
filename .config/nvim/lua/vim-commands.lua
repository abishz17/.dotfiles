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
vim.opt.ignorecase = true
vim.cmd("set nowrap")
vim.keymap.set("n", "<C-S-k>", "<cmd>m -2<CR>")
vim.keymap.set("n", "<C-S-j>", "<cmd>m +1<CR>")
vim.lsp.set_log_level("debug")
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

vim.keymap.set("n", "<leader>ef", function()
  local diagnostics = vim.diagnostic.get(0) -- `0` is the current buffer

  if vim.tbl_isempty(diagnostics) then
    vim.notify("No diagnostics in the buffer", vim.log.levels.INFO)
    return
  end

  local messages = {}
  for _, diagnostic in ipairs(diagnostics) do
    local line = diagnostic.lnum + 1
    table.insert(messages, string.format("Line %d: %s", line, diagnostic.message))
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, messages)

  for i = 0, #messages - 1 do
    vim.api.nvim_buf_add_highlight(buf, -1, "Error", i, 0, -1)
  end

  local width = math.max(40, vim.fn.winwidth(0) - 20)
  local height = math.min(10, #messages)
  local opts = {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
  }

  vim.api.nvim_open_win(buf, true, opts)

  vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
end, { desc = "Show diagnostics in a floating window with red errors" })

--Quick fix list navigation

vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

--Put all errors in a quickfix list
vim.keymap.set("n", "<leader>ew", function()
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end)
