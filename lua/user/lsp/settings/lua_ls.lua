return {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT", -- Neovim 内部用的 Lua 版本
			},
			diagnostics = {
				globals = { "vim" }, -- 允许识别全局变量 vim
			},
			workspace = {
				checkThirdParty = false, -- 不再弹 annoying 的第三方警告
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.stdpath("config") .. "/lua",
				},
			},
			format = {
				enable = true, -- ✅ 启用格式化（lua_ls 会用 stylua）
				defaultConfig = {
					indent_style = "tab",
					indent_size = "4",
					quote_style = "auto",
				},
			},
			telemetry = { enable = false }, -- 可选：关闭遥测
		},
	},
}
