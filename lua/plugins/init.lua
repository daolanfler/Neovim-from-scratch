return {                      -- My plugins here
  "nvim-lua/popup.nvim",      -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim",    -- Useful lua functions used ny lots of plugins
  "windwp/nvim-autopairs",    -- Autopairs, integrates with both cmp and treesitter
  "numToStr/Comment.nvim",    -- Easily comment stuff

  "kyazdani42/nvim-tree.lua", --
  "akinsho/bufferline.nvim",  --
  "moll/vim-bbye",            --

  -- lunarvim/colorschemes, -- A bunch of colorschemes you can try out
  "lunarvim/darkplus.nvim",
  "ellisonleao/gruvbox.nvim",     -- cmp plugins
  "hrsh7th/nvim-cmp",             -- The completion plugin
  "hrsh7th/cmp-buffer",           -- buffer completions
  "hrsh7th/cmp-path",             -- path completions
  "hrsh7th/cmp-cmdline",          -- cmdline completions
  "saadparwaiz1/cmp_luasnip",     -- snippet completions
  "hrsh7th/cmp-nvim-lsp",         -- snippets
  "L3MON4D3/LuaSnip",             -- snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -- LSP
  "neovim/nvim-lspconfig",               -- enable LSP
  "williamboman/mason.nvim",             -- simple to use language server installer
  "williamboman/mason-lspconfig.nvim",
  "tamago324/nlsp-settings.nvim",        -- language server settings defined in json or yaml

  "jose-elias-alvarez/null-ls.nvim",     -- for formatters and linters

  "lukas-reineke/indent-blankline.nvim", -- indent blankline for decoration
  "nvim-telescope/telescope.nvim",       -- Telescope

  -- Treesitter, ast syntax-highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      pcall(require("nvim-treesitter.install").update({
        with_sync = true,
      }))
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  },

  -- { "nvim-treesitter/playground" },

  -- "JoosepAlviste/nvim-ts-context-commentstring",

  "lewis6991/gitsigns.nvim",

  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "VeryLazy",
  },

  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },
}
