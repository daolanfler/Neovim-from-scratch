return {
	"tpope/vim-fugitive",
	event = "VeryLazy",
	config = function()
		vim.keymap.set("n", "<leader>mg", vim.cmd.Git)
	end
}