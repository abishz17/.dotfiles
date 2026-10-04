-- Tracks main (OpenCode v2 support); tagged releases only support OpenCode v1.
vim.pack.add({ 'https://github.com/nickjvandyke/opencode.nvim' })

vim.g.opencode_opts = {
  server = {
    -- Called when no running opencode is found: open one in a kitty split, keep focus in nvim.
    -- Needs kitty remote control (allow_remote_control + listen_on in kitty.conf).
    start = function()
      vim.system({ "kitty", "@", "launch", "--location=vsplit", "--keep-focus", "--cwd=" .. vim.fn.getcwd(), "opencode" })
    end,
  },
}

vim.o.autoread = true

vim.keymap.set({ "n", "x" }, "<leader>aa", function()
  require("opencode").ask("@this: ")
end, { desc = "Ask opencode" })

vim.keymap.set({ "n", "x" }, "<leader>as", function()
  require("opencode").select()
end, { desc = "Opencode select action" })

vim.keymap.set({ "n", "x" }, "go", function()
  return require("opencode").operator("@this ")
end, { desc = "Add range to opencode", expr = true })

vim.keymap.set("n", "goo", function()
  return require("opencode").operator("@this ") .. "_"
end, { desc = "Add line to opencode", expr = true })
