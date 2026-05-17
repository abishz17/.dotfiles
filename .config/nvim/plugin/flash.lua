vim.pack.add('https://github.com/folke/flash.nvim')

local flash = require("flash")

flash.setup({
  labels = "asdfghjklqwertyuiopzxcvbnm",
  search = {
    multi_window = true,
    forward = true,
    wrap = true,
  },
  jump = {
    jumplist = true,
    autojump = false,
  },
  label = {
    uppercase = false,
    after = true,
  },
  modes = {
    char = {
      enabled = true,   -- enhances f/F/t/T with flash labels on repeat
      jump_labels = true,
    },
    search = {
      enabled = false,  -- don't hijack / search
    },
  },
})

vim.keymap.set({ "n", "x", "o" }, "s", flash.jump, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", flash.treesitter, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", flash.remote, { desc = "Remote Flash" })
vim.keymap.set("c", "<C-s>", flash.toggle, { desc = "Toggle Flash in search" })
