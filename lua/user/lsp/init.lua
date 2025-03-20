local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

--[[ local lsp = require("lsp-zero") ]]
--[[ lsp.preset("recommended") ]]
--[[ lsp.setup(); ]]

require "user.lsp.mason"
require("user.lsp.handlers").setup()