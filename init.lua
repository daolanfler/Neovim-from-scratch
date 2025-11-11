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

vim.api.nvim_create_user_command("ShowMessages", function()
	local msgs = vim.api.nvim_exec("messages", true)
	if msgs == "" then
		vim.notify("No messages to show", vim.log.levels.INFO)
		return
	end

	-- 创建一个新的 buffer（非临时，不共享窗口）
	local buf = vim.api.nvim_create_buf(true, false) -- [listed=true], [scratch=false]
	vim.api.nvim_buf_set_name(buf, "MessagesBuffer")
	vim.api.nvim_buf_set_option(buf, "filetype", "log")
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(msgs, "\n"))

	-- 在新 tabpage 打开
	-- vim.cmd("tabnew")  -- tab is something I rarely use in neovim
	vim.api.nvim_set_current_buf(buf)
end, { desc = "Show :messages in a new buffer" })