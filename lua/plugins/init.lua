-- You don't necessaril need to specify the plugin name, if you've already put it in `./lua/plugins` folder
return {                                               -- My plugins here
	"nvim-lua/popup.nvim",                             -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim",                           -- Useful lua functions used ny lots of plugins
	-- "kyazdani42/nvim-tree.lua", -- use Neo tree instead
	"moll/vim-bbye",                                   --
	-- lunarvim/colorschemes, -- A bunch of colorschemes you can try out
	"lunarvim/darkplus.nvim", "ellisonleao/gruvbox.nvim", -- cmp plugins
	"hrsh7th/nvim-cmp",                                -- The completion plugin
	"hrsh7th/cmp-buffer",                              -- buffer completions
	"hrsh7th/cmp-path",                                -- path completions
	"hrsh7th/cmp-cmdline",                             -- cmdline completions
	"saadparwaiz1/cmp_luasnip",                        -- snippet completions
	"hrsh7th/cmp-nvim-lsp",                            -- snippets
	"L3MON4D3/LuaSnip",                                -- snippet engine
	"rafamadriz/friendly-snippets",                    -- a bunch of snippets to use
	"folke/which-key.nvim",                            -- LSP
	"neovim/nvim-lspconfig",                           -- enable LSP
	"williamboman/mason.nvim",                         -- simple to use language server installer
	"williamboman/mason-lspconfig.nvim",
	"tamago324/nlsp-settings.nvim",                    -- language server settings defined in json or yaml
	{
		'nvimdev/lspsaga.nvim',
		config = function()
			require('lspsaga').setup({
				lightbulb = {
					enable = false
				}
			})
		end,
		dependencies = {
			'nvim-treesitter/nvim-treesitter', -- optional
			'nvim-tree/nvim-web-devicons', -- optional
		}
	},
	{
		"onsails/lspkind.nvim",
		event = "VeryLazy",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = '┊'
			}
		}
	},
	{
		'nvim-telescope/telescope.nvim',
		-- tag = '0.1.4',
		-- or                              , branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	-- Treesitter, ast syntax-highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			pcall(require("nvim-treesitter.install").update({
				with_sync = true
			}))
		end,
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" }
	},
	{
		's1n7ax/nvim-window-picker',
		name = 'window-picker',
		event = 'VeryLazy',
		version = '2.*',
		config = function()
			require 'window-picker'.setup()
		end
	},
	-- { "nvim-treesitter/playground" },
	-- "JoosepAlviste/nvim-ts-context-commentstring",
	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		event = "VeryLazy"
	},
	{
		"ThePrimeagen/harpoon"
	},
	-- {
	--   "iamcco/markdown-preview.nvim",
	--   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	--   build = "cd app && npm install",
	--   init = function()
	--     vim.g.mkdp_filetypes = { "markdown" }
	--   end,
	--   ft = { "markdown" },
	-- },
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	},
	{
		"projekt0n/github-nvim-theme",
		lazy = false,
		priority = 1000,
		config = function()
			require("github-theme").setup({
				options = {
					transparent = false,
				}
			})
		end,
	}
}