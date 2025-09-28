function ColorMyPencils(color)
	color = color or 'gruvbox'
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", {
		bg = "none"
	});

	vim.api.nvim_set_hl(0, "NormalFloat", {
		bg = "none"
	});
	local is_wsl = vim.fn.has("wsl") == 1

	-- windows terminal does have great support for italic chinese characters rendering
	if is_wsl then
		vim.api.nvim_set_hl(0, "Comment", {
			fg = "#808080",
			italic = false
		})
	end
end

ColorMyPencils('darkplus')