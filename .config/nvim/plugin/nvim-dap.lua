-- nvim-dap (local plugin from ~/personal/nvim-dap) + dap-ui
--
-- Since nvim-dap is a local plugin NOT managed by vim.pack, we use a symlink
-- in a dedicated "mine" package and load it with vim.cmd.packadd().
--
-- Setup: Create a symlink (only need to do this once):
--   mkdir -p ~/.local/share/nvim/site/pack/mine/opt
--   ln -s ~/personal/nvim-dap ~/.local/share/nvim/site/pack/mine/opt/nvim-dap

-- Load vim.pack-managed dap plugins
vim.pack.add({
  'https://github.com/leoluz/nvim-dap-go',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/rcarriga/nvim-dap-ui',
})

-- Load local nvim-dap
vim.cmd.packadd('nvim-dap')

-- Signs
for _, group in pairs({
  "DapBreakpoint",
  "DapBreakpointCondition",
  "DapBreakpointRejected",
  "DapLogPoint",
}) do
  vim.fn.sign_define(group, { text = "●", texthl = group })
end

-- Setup
require("dap").defaults.fallback.switchbuf = "usevisible,usetab,newtab"

-- Adapters: C, C++, Rust
local dap = require("dap")
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
    args = { "--port", "${port}" },
  },
}

dap.configurations.cpp = {
  {
    name = "Launch file (CodeLLDB)",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}

dap.configurations.c = dap.configurations.cpp

require("dap-go").setup({
  dap_configurations = {
    {
      type = "go",
      name = "Debug-tigg",
      request = "launch",
      program = "${workspaceFolder}/cmd/main.go",
    },
  },
})

-- Keymaps (were lazy-loaded via keys in lazy.nvim, now always available)
vim.keymap.set("n", "<leader>ds", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes, { border = "rounded" })
end, { desc = "DAP Scopes" })

vim.keymap.set("n", "<F1>", function()
  require("dap.ui.widgets").hover(nil, { border = "rounded" })
end, { desc = "DAP Hover" })

vim.keymap.set("n", "<F4>", "<CMD>DapTerminate<CR>", { desc = "DAP Terminate" })
vim.keymap.set("n", "<leader>dr", "<CMD>DapContinue<CR>", { desc = "DAP Continue" })
vim.keymap.set("n", "<F6>", function() require("dap").run_to_cursor() end, { desc = "Run to Cursor" })
vim.keymap.set("n", "<leader>db", "<CMD>DapToggleBreakpoint<CR>", { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<F10>", "<CMD>DapStepOver<CR>", { desc = "Step Over" })
vim.keymap.set("n", "<F11>", "<CMD>DapStepInto<CR>", { desc = "Step Into" })
vim.keymap.set("n", "<F12>", "<CMD>DapStepOut<CR>", { desc = "Step Out" })
vim.keymap.set("n", "<F17>", function() require("dap").run_last() end, { desc = "Run Last" })
vim.keymap.set("n", "<F21>", function()
  vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
    require("dap").set_breakpoint(input)
  end)
end, { desc = "Conditional Breakpoint" })
vim.keymap.set("n", "<A-r>", function()
  require("dap").repl.toggle(nil, "tab split")
end, { desc = "Toggle DAP REPL" })

-- DAP UI
local dapui = require("dapui")
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
