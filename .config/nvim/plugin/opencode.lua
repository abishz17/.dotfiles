vim.pack.add({ 'https://github.com/nickjvandyke/opencode.nvim' })

vim.g.opencode_opts = {
  provider = {
    enabled = "kitty",
  },
}

vim.o.autoread = true

vim.keymap.set({ "n", "x" }, "<leader>aa", function()
  require("opencode").ask("@this: ", { submit = true })
end, { desc = "Ask opencode" })

vim.keymap.set({ "n", "x" }, "<leader>as", function()
  require("opencode").select()
end, { desc = "Opencode select action" })

vim.keymap.set({ "n", "t" }, "<leader>toc", function()
  require("opencode").toggle()
end, { desc = "Toggle opencode" })

vim.keymap.set({ "n", "x" }, "go", function()
  return require("opencode").operator("@this ")
end, { desc = "Add range to opencode", expr = true })

vim.keymap.set("n", "goo", function()
  return require("opencode").operator("@this ") .. "_"
end, { desc = "Add line to opencode", expr = true })

vim.keymap.set("n", "<leader>au", function()
  require("opencode").command("session.half.page.up")
end, { desc = "Scroll opencode up" })

vim.keymap.set("n", "<leader>ad", function()
  require("opencode").command("session.half.page.down")
end, { desc = "Scroll opencode down" })
