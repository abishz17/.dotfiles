return {

  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  -- or                              , branch = '0.1.x',
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<C-p>", function()
      builtin.find_files({
        hidden = true,
        find_command = {
          "rg",
          "--files",
          "--hidden",
          "--glob=!**/.git/*",
          "--glob=!**/.idea/*",
          "--glob=!**/.vscode/*",
          "--glob=!**/build/*",
          "--glob=!**/dist/*",
          "--glob=!**/yarn.lock",
          "--glob=!**/package-lock.json",
        },
      })
    end, { noremap = true, silent = true })
    vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
    vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
    vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
    vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    vim.keymap.set("n", "<leader>f", function()
      require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })
  end,
}
