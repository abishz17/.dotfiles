vim.pack.add({
  { src = 'https://github.com/mrcjkb/rustaceanvim', version = vim.version.range('9.x') },
})

vim.g.rustaceanvim = {
  tools = {
    -- rustaceanvim defaults to true. Explicit is better than implicit.
    enable_clippy = true,
  },
  server = {
    on_attach = function(client, bufnr)
      client.server_capabilities.semanticTokensProvider = nil
    end,
    default_settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = false,
          targetDir = true,
          buildScripts = { enable = true },
        },
        check = {
          command = "clippy",
          workspace = false,
          extraArgs = { "--no-deps" },
        },
        diagnostics = {
          enable = true,
          experimental = { enable = false },
          styleLints = { enable = false },
          disabled = { "unused_variables","unused_mut" },
        },
        procMacro = {
          enable = true,
          processes = 2,
        },
        lru = {
          capacity = 256,
        },
        cachePriming = {
          enable = true,
          numThreads = "physical",
        },
        inlayHints = {
          chainingHints = { enable = true },
          parameterHints = { enable = true },
          typeHints = { enable = true },
          closingBraceHints = {
            enable = true,
            minLines = 20,
          },
          maxLength = 30,
        },
      },
    },
  },
}
