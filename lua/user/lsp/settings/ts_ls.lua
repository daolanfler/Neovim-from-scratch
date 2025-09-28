-- 使用 rustup component 中的  rust-analyzer
local opts = {
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = "/Users/qi/Library/pnpm/global/5/node_modules/@vue/typescript-plugin",
				languages = { "javascript", "typescript", "vue" },
			},
		},
	},
	filetypes = {
		"javascript",
		"typescript",
		"vue",
	},
}

return opts
