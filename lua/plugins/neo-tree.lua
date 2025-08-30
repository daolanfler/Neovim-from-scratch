return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim"
	},
	keys = { {
		"<leader>e",
		"<cmd>Neotree toggle<cr>",
		desc = "Neotree"
	} },
	opts = {
		filesystem = {
			follow_current_file = {
				enabled = true
			},
			hijack_netrw_behavior = "open_current",
			-- filtered_items = {
			-- 	visible = true,
			-- 	show_hidden_count = true,
			-- 	hide_dotfiles = false,
			-- 	hide_gitignored = true,
			-- 	hide_by_name = { '.git', '.DS_Store', 'thumbs.db' },
			-- 	never_show = {}
			-- }
		}
	}
}