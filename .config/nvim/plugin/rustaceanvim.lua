-- Rustaceanvim
vim.pack.add({
  { src = 'https://github.com/mrcjkb/rustaceanvim', version = vim.version.range('9.x') },
})

vim.g.rustaceanvim = {
  server = {
    default_settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
        check = {
          command = "clippy",
        },
        diagnostics = {
          enable = true,
          experimental = { enable = true },
          styleLints = { enable = true },
        },
        inlayHints = {
          chainingHints = { enable = true },
          parameterHints = { enable = true },
          typeHints = { enable = true },
        },
      },
    },
  },
}
