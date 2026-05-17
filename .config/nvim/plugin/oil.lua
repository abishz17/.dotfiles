-- Oil: lazy load on first keymap use or directory open
local loaded = false
local function load_oil()
  if loaded then return end
  loaded = true
  vim.pack.add({
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/stevearc/oil.nvim',
  })
  require("oil").setup({
    columns = { "icon" },
    keymaps = {
      ["<C-h>"] = false,
      ["<M-h>"] = "actions.select_split",
      ["<C-u>"] = "actions.preview",
      ["<C-p>"] = false,
    },
    view_options = {
      show_hidden = true,
    },
  })
end

vim.keymap.set("n", "-", function()
  load_oil()
  vim.cmd("Oil")
end, { desc = "Open parent directory" })

vim.keymap.set("n", "<space>-", function()
  load_oil()
  require("oil").toggle_float()
end)

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    local path = vim.fn.argv(0)
    if path ~= "" and vim.fn.isdirectory(path) == 1 then
      load_oil()
      vim.schedule(function()
        require("oil").open(path)
      end)
    end
  end,
})
