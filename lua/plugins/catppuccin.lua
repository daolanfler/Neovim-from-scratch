-- Light theme counterpart of the default dark theme (see `lua/user/colorscheme.lua`)
return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false, -- must be available before `user.colorscheme` is required
	priority = 1000,
	opts = {
		flavour = "latte",
		background = {
			light = "latte",
			dark = "mocha",
		},
	},
}
