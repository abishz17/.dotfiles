return {
	"olexsmir/gopher.nvim",
	ft = "go",
	config = function(_, opts)
		require("gopher").setup(opts)
		vim.api.nvim_set_keymap("n", "<leader>gsj", [[<cmd>GoTagAdd json<CR>]], { noremap = true, silent = true })
	end,
	build = function()
		vim.cmd([[silent! GoInstallDeps]])
	end,
}
