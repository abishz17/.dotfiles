-- Telescope
vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim', name = 'telescope-fzf-native.nvim' },
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
})

local builtin = require("telescope.builtin")
require("telescope").setup({
  pickers = {
    find_files = {
      theme = "ivy",
    },
  },
  extensions = {
    fzf = {},
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")

vim.keymap.set("n", "<C-p>", builtin.find_files)
vim.keymap.set("n", "<space>en", function()
  builtin.find_files({
    cwd = vim.fn.stdpath("config"),
  })
end)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "sr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP References in Telescope" })
vim.keymap.set("n", "<leader>fq", function()
  require("telescope.builtin").quickfix()
end, { desc = "Telescope quickfix list" })
