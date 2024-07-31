return {
	"ray-x/lsp_signature.nvim",
	event = "VeryLazy",
	lazy = false,
	opts = {},
	config = function(_, opts)
		require("lsp_signature").setup(opts)

		-- vim.keymap.set({ "n" }, "<C-k>", function()
		-- 	require("lsp_signature").toggle_float_win()
		-- end, { silent = true, noremap = true, desc = "toggle signature" })

		-- vim.keymap.set({ "n" }, "<Leader>k", function()
		-- 	vim.lsp.buf.signature_help()
		-- end, { silent = true, noremap = true, desc = "toggle signature" })
	end
}