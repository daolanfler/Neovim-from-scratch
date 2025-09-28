---@diagnostic disable-next-line: undefined-global
local vim = vim
local actions = require "telescope.actions"

return {
	'nvim-telescope/telescope.nvim',
	event = 'VimEnter',
	dependencies = { 'nvim-lua/plenary.nvim',
		{
			-- If encountering errors, see telescope-fzf-native README for install instructions
			'nvim-telescope/telescope-fzf-native.nvim',

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = 'make',

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable 'make' == 1
			end
		},
		{ 'nvim-telescope/telescope-ui-select.nvim' }, -- Useful for getting pretty icons, but requires special font.
		--  If you already have a Nerd Font, or terminal set up with fallback fonts
		--  you can enable this
		{ 'nvim-tree/nvim-web-devicons' }
	},

	config = function()
		require("telescope").setup {
			defaults = {
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top"
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
					n = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					}
				},
			},
			extensions = {
				-- Your extension configuration goes here:
				-- extension_name = {
				--   extension_config_key = value,
				-- }
				-- please take a look at the readme of the extension you want to configure
				['ui-select'] = { require('telescope.themes').get_dropdown() }
			}
		}

		-- Enable telescope extensions, if they are installed
		pcall(require('telescope').load_extension, 'fzf')
		pcall(require('telescope').load_extension, 'ui-select')

		-- See `:help telescope.builtin`
		local builtin = require 'telescope.builtin'
		vim.keymap.set('n', '<leader>sh', builtin.help_tags, {
			desc = '[S]earch [H]elp'
		})
		vim.keymap.set('n', '<leader>sk', builtin.keymaps, {
			desc = '[S]earch [K]eymaps'
		})
		vim.keymap.set('n', '<leader>sf', builtin.find_files, {
			desc = '[S]earch [F]iles'
		})
		vim.keymap.set('n', '<leader>ss', builtin.builtin, {
			desc = '[S]earch [S]elect Telescope'
		})
		vim.keymap.set('n', '<leader>sw', builtin.grep_string, {
			desc = '[S]earch current [W]ord'
		})
		vim.keymap.set('n', '<leader>sg', builtin.live_grep, {
			desc = '[S]earch by [G]rep'
		})
		vim.keymap.set('n', '<leader>sd', builtin.diagnostics, {
			desc = '[S]earch [D]iagnostics'
		})
		vim.keymap.set('n', '<leader>sr', builtin.resume, {
			desc = '[S]earch [R]esume'
		})
		vim.keymap.set('n', '<leader>s.', builtin.oldfiles, {
			desc = '[S]earch Recent Files ("." for repeat)'
		})
		vim.keymap.set('n', '<leader><leader>', builtin.buffers, {
			desc = '[ ] Find existing buffers'
		})

		vim.keymap.set('n', '<C-p>', builtin.find_files, {
			desc = 'Search Files'
		})

		-- Telescrop related
		-- vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<CR>", opts)
		-- vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", opts)

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set('n', '<leader>/', function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
				winblend = 10,
				previewer = false
			})
		end, {
			desc = '[/] Fuzzily search in current buffer'
		})

		-- Also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set('n', '<leader>s/', function()
			builtin.live_grep {
				grep_open_files = true,
				prompt_title = 'Live Grep in Open Files'
			}
		end, {
			desc = '[S]earch [/] in Open Files'
		})

		-- Shortcut for searching your neovim configuration files
		vim.keymap.set('n', '<leader>sn', function()
			builtin.find_files {
				cwd = vim.fn.stdpath 'config'
			}
		end, {
			desc = '[S]earch [N]eovim files'
		})
	end
}