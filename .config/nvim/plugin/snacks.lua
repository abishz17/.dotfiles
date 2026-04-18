vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

local Snacks = require("snacks")

Snacks.setup({
  bigfile = { enabled = true },
  quickfile = { enabled = true },
  input = { enabled = true },
  scroll = { enabled = true },
  indent = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 3000,
  },

  picker = {
    actions = {
      opencode_send = function(...)
        return require("opencode").snacks_picker_send(...)
      end,
    },
    win = {
      input = {
        keys = {
          ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
        },
      },
    },
  },
  styles = {
    notification = {
      wo = { wrap = true },
    },
  },
  dashboard = {
    preset = {
      header = [[
              ________________________________________________
             /                                                \
            |    _________________________________________     |
            |   |                                         |    |
            |   |  abish/                                 |    |
            |   |                                         |    |
            |   |                                         |    |
            |   |                                         |    |
            |   |                                         |    |
            |   |                                         |    |
            |   |                                         |    |
            |   |                                         |    |
            |   |_________________________________________|    |
            |                                                  |
             \_________________________________________________/
                   \___________________________________/
                ___________________________________________
             _-'    .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.  --- `-_
           _-'.-.-. .---.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.--.  .-.-.`-_
        _-'.-.-.-. .---.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-`__`. .-.-.-.`-_
     _-'.-.-.-.-. .-----.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-----. .-.-.-.-.`-_
  _-'.-.-.-.-.-. .---.-. .-------------------------. .-.---. .---.-.-.-.`-_
:-------------------------------------------------------------------------:
`---._.-------------------------------------------------------------._.---']],
    },
    sections = {
      { section = "header" },
      { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
      {
        icon = " ",
        title = "Recent Files",
        section = "recent_files",
        limit = 5,
        cwd = true,
        indent = 2,
        padding = 1,
      },
      {
        icon = " ",
        title = "Git Status",
        section = "terminal",
        enabled = function()
          return Snacks.git.get_root() ~= nil
        end,
        cmd = "git status --short --branch --renames",
        height = 5,
        padding = 1,
        ttl = 5 * 60,
        indent = 2,
      },
    },
  },
  image = {},
})

vim.keymap.set("n", "<leader>.", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
vim.keymap.set("n", "<leader>S", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })
vim.keymap.set("n", "<leader>n", function() Snacks.notifier.show_history() end, { desc = "Notification History" })
vim.keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>cR", function() Snacks.rename.rename_file() end, { desc = "Rename File" })
vim.keymap.set("n", "<leader>go", function() Snacks.gitbrowse() end, { desc = "Git Browse" })
vim.keymap.set("n", "<leader>gb", function() Snacks.git.blame_line() end, { desc = "Git Blame Line" })
vim.keymap.set("n", "<leader>gf", function() Snacks.lazygit.log_file() end, { desc = "Lazygit Current File History" })
vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })
vim.keymap.set("n", "<leader>gl", function() Snacks.lazygit.log() end, { desc = "Lazygit Log (cwd)" })
vim.keymap.set("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })
vim.keymap.set({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
vim.keymap.set({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })

vim.schedule(function()
  _G.dd = function(...)
    Snacks.debug.inspect(...)
  end
  _G.bt = function()
    Snacks.debug.backtrace()
  end
  vim.print = _G.dd

  Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
  Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
  Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
  Snacks.toggle.diagnostics():map("<leader>ud")
  Snacks.toggle.line_number():map("<leader>ul")
  Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
  Snacks.toggle.treesitter():map("<leader>uT")
  Snacks.toggle.inlay_hints():map("<leader>uh")
end)
