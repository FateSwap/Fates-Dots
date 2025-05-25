return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            theme = 'gruvbox',
	    disabled_filetypes = { 'snacks_dashboard' },
        }
    }
}
