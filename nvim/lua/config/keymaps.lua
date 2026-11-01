-- config/keymaps.lua

-- Sets leader key to space
vim.g.mapleader = " "

-- Opens Netrw ( vim file manager )
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Netrw" })

-- Writes file
vim.keymap.set("n", "<leader>w", vim.cmd.write, { desc = "Write file" })

-- Actually quit vim
vim.keymap.set('n', '<leader>qq', vim.cmd.quit, { desc = "Quit vim" })

-- Source current file
vim.keymap.set("n", "<leader>s", vim.cmd.source, { desc = "Source buffer" })

-- Lsp quickfix list
vim.keymap.set("n", "<leader>di", function()
	vim.diagnostic.setqflist()
	vim.cmd("copen")
end, { desc = "Open diagnostics list" })
vim.keymap.set("n", "<leader>q", "<cmd>cclose<cr>", { desc = "Close quickfix list" })

-- Run java file
vim.keymap.set("n", "<leader>j", "<cmd>!java %<CR>", { desc = "Runs java file" })

-- Conform.nvim
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({
		async = true,
		lsp_format = "fallback",
	})
end, {
	desc = "Format buffer",
})

-- Primagen replace
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Keymap template:
-- vim.keymap.set(MODE, KEY, ACTION, {
--   desc = 'Brief explanation',
-- })
--
-- Examples:
-- MODE:   'n' = Normal, 'i' = Insert, 'v' = Visual, 't' = Terminal
-- KEY:    '<leader>x', '<C-s>' (Ctrl+s), '<Esc>'
-- ACTION: '<cmd>SomeCommand<CR>' or a Lua function
--
-- Example:
-- vim.keymap.set('n', '<leader>w', '<cmd>write<CR>', {
--   desc = 'Save file',
-- })
--
-- Use '<cmd>Command<CR>' to map directly to a Neovim command.
-- Use vim.cmd('Command') inside a Lua function when you need to run
-- a Neovim command as part of other Lua logic.
