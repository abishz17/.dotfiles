-- crates.nvim: versions, completion and upgrade actions inside Cargo.toml.
-- Its in-process LSP feeds completion to blink.cmp's "lsp" source, no extra source needed.
vim.pack.add({ { src = 'https://github.com/saecki/crates.nvim', version = 'stable' } })

-- Only set up when a Cargo.toml is opened; setup() attaches to the current buffer itself.
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "Cargo.toml",
  once = true,
  callback = function()
    require("crates").setup({
      completion = { crates = { enabled = true } },
      lsp = { enabled = true, actions = true, completion = true, hover = true },
    })
  end,
})
