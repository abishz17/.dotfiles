return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = { "html", "c", "lua", "vim", "vimdoc", "query", "go", "python", "rust", "toml", "sql" },
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
