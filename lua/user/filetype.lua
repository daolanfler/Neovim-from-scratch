vim.filetype.add({
	pattern = {
		['.*'] = function(_, bufnr)
			local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""

			if first_line:match('^#!.*/bash') or first_line:match('^#!.*/env%s+bash') then
				return 'sh'

			elseif first_line:match('^#!.*/zsh') or first_line:match('^#!.*/env%s+zsh') then
				return 'sh' -- zsh 也用 bashls 处理
			end
		end,
	},
})