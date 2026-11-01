return {
	{
		"neovim/nvim-lspconfig",
		"nvim-java/nvim-java",
		config = function()
			vim.lsp.enable({
				"lua_ls",
				"nil_ls",
				"jdtls",
			})
		end,
	},
}
