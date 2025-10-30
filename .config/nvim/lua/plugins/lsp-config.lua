return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"gopls",
					"pyright",
					"rust_analyzer",
					"clangd",
					"ts_ls",
					"tailwindcss",
					"bashls",
					"yamlls",
				},
				automatic_enable = false,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Get capabilities from blink.cmp
			local capabilities = require("blink.cmp").get_lsp_capabilities({
				textDocument = { completion = { completionItem = { snippetSupport = false } } },
			})

			-- List of language servers to configure
			local servers = {
				{ "lua_ls" },
				{ "tailwindcss" },
				{ "pyright" },
				{
					"clangd",
					{
						cmd = {
							"clangd",
							"--header-insertion=never",
						},
					},
				},
				{ "dockerls" },
				{ "bashls" },
				{ "sqlls" },
				{ "yamlls" },
				{
					"gopls",
					{
						cmd = { "gopls" },
						settings = {
							gopls = {
								completeUnimported = true,
								usePlaceholders = true,
								analyses = {
									unusedparams = true,
								},
							},
						},
					},
				},
				{
					"rust_analyzer",
					{
						filetypes = { "rust" },
						root_dir = function(fname)
							local util = require("lspconfig.util")
							return util.root_pattern("Cargo.toml")(fname)
						end,
						settings = {
							["rust-analyzer"] = {
								cargo = {
									allFeatures = true,
								},
								checkOnSave = {
									command = "clippy",
								},
								rustfmt = {},
							},
						},
					},
				},
				{ "ts_ls" },
				{ "ocamllsp" },
			}


			for _, server in ipairs(servers) do
				local name = server[1]
				local config = server[2] or {}

				config.capabilities = capabilities

				vim.lsp.config(name, config)

				vim.lsp.enable(name)
			end

			-- Set up keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
