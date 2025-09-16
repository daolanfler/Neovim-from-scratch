require "user.options"
require "user.keymaps"

-- with lazy.nvim just put new plugins in `lua/plugins` folder, Lazy will load them
-- for more information see the yotube video "migrating from packer to lazy"
require "user.plugins"

require "user.lsp"
require "user.colorscheme"
require "user.filetype"

-- Hightlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = "Hightlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("me-highlight-yank", {
		clear = true
	}),
	callback = function()
		vim.highlight.on_yank()
	end
})