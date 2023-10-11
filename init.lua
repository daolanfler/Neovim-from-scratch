require "user.options"
require "user.keymaps"

-- with lazy.nvim just put new plugins in `lua/plugins` folder, Lazy will load them 
-- for more information see the yotube video "migrating from packer to lazy"
require "user.plugins"

require "user.colorscheme"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.autopairs"
require "user.comment"
require "user.gitsigns"

require "user.bufferline"
require "user.fugitive"
