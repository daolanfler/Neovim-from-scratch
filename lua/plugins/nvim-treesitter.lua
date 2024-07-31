return {
	'nvim-treesitter/nvim-treesitter',
	config = function()
		require 'nvim-treesitter'.setup({
			ensure_installed = { "lua", "bash", "rust", "javascript", "typescript", "vue", "go" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
			sync_install = false,                                                                -- install languages synchronously (only applied to `ensure_installed`)
			ignore_install = { "" },                                                             -- List of parsers to ignore installing
			autopairs = {
				enable = true
			},
			highlight = {
				enable = true,  -- false will disable the whole extension
				disable = { "" }, -- list of language that will be disabled
				additional_vim_regex_highlighting = true
			},
			indent = {
				enable = true,
				disable = { "yaml" }
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false
			}
		})
	end
}