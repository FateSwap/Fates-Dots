return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install({
				"lua",
				"vimdoc",
				"nix",
				"vim",
				"bash",
			})
		end,
	},
}
