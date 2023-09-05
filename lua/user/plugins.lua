local fn = vim.fn

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    return
end

-- Install your plugins here
return lazy.setup({ -- My plugins here
"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
"numToStr/Comment.nvim", -- Easily comment stuff
"kyazdani42/nvim-web-devicons", "kyazdani42/nvim-tree.lua", "akinsho/bufferline.nvim", "moll/vim-bbye",
"nvim-lualine/lualine.nvim", "akinsho/toggleterm.nvim", -- Colorschemes

-- lunarvim/colorschemes, -- A bunch of colorschemes you can try out
"lunarvim/darkplus.nvim", "ellisonleao/gruvbox.nvim", -- cmp plugins
"hrsh7th/nvim-cmp", -- The completion plugin
"hrsh7th/cmp-buffer", -- buffer completions
"hrsh7th/cmp-path", -- path completions
"hrsh7th/cmp-cmdline", -- cmdline completions
"saadparwaiz1/cmp_luasnip", -- snippet completions
"hrsh7th/cmp-nvim-lsp", -- snippets
"L3MON4D3/LuaSnip", -- snippet engine
"rafamadriz/friendly-snippets", -- a bunch of snippets to use

-- LSP
"neovim/nvim-lspconfig", -- enable LSP
"williamboman/mason.nvim", -- simple to use language server installer
"williamboman/mason-lspconfig.nvim", "tamago324/nlsp-settings.nvim", -- language server settings defined in json for
"jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
'lukas-reineke/indent-blankline.nvim', -- Telescope
"nvim-telescope/telescope.nvim", -- Treesitter

{
    "nvim-treesitter/nvim-treesitter",
    build = function() 
      pcall(require('nvim-treesitter.install').update {with_sync=true})
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    }
}, 

{"nvim-treesitter/playground"}, "JoosepAlviste/nvim-ts-context-commentstring", "mbbill/undotree", -- Git


"lewis6991/gitsigns.nvim", {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim"
}, "tpope/vim-fugitive" -- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
-- if PACKER_BOOTSTRAP then
--   require("packer").sync()
-- end
})
