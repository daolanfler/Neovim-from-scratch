-- Detect indentation from the file itself (tabs vs spaces, and the width)
-- instead of relying on the global defaults in `user/options.lua`.
-- .editorconfig files still win: sleuth reads them before guessing.
return {
	"tpope/vim-sleuth",
	lazy = false, -- works through BufReadPost autocmds, must be loaded at startup
}
