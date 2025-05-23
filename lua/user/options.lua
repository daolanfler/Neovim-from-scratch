local options = {
	backup = false,                       -- creates a backup file
	-- clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
	cmdheight = 1,                        -- more space in the neovim command line for displaying messages
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0,                     -- so that `` is visible in markdown files
	fileencoding = "utf-8",               -- the encoding written to a file
	hlsearch = true,                      -- highlight all matches on previous search pattern
	ignorecase = true,                    -- ignore case in search patterns
	mouse = "a",                          -- allow the mouse to be used in neovim
	pumheight = 10,                       -- pop up menu height
	showmode = false,                     -- we don't need to see things like -- INSERT -- anymore
	showtabline = 2,                      -- always show tabs
	smartcase = true,                     -- smart case
	smartindent = true,                   -- make indenting smarter again
	splitbelow = true,                    -- force all horizontal splits to go below current window
	splitright = true,                    -- force all vertical splits to go to the right of current window
	swapfile = false,                     -- creates a swapfile
	termguicolors = true,                 -- set term gui colors (most terminals support this)
	timeoutlen = 1000,                    -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true,                      -- enable persistent undo
	updatetime = 300,                     -- faster completion (4000ms default)
	writebackup = false,                  -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true,                     -- convert tabs to spaces
	shiftwidth = 4,                       -- the number of spaces inserted for each indentation
	tabstop = 4,                          -- insert 2 spaces for a tab
	cursorline = true,                    -- highlight the current line
	number = true,                        -- set numbered lines
	relativenumber = true,                -- set relative numbered lines
	numberwidth = 4,                      -- set number column width to 2 {default 4}
	signcolumn = "yes",                   -- always show the sign column, otherwise it would shift the text each time
	wrap = false,                         -- display lines as one long line
	scrolloff = 8,                        -- is one of my fav
	sidescrolloff = 8,
	guifont = "monospace:h17",            -- the font used in graphical neovim applications
	breakindent = true
}
--
-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set("n", '<Esc>', '<cmd>nohlsearch<CR>')

vim.opt.shortmess:append "c"
vim.opt.shortmess:append "W"

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		local fo = vim.opt_local.formatoptions
		fo:remove("c")
		fo:remove("r")
		fo:remove("o")
	end,
})

-- 自动将工作目录设置为打开的目录
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local argv = vim.fn.argv(0) -- argv 可能是数组，也可能是 string
		if type(argv) == "string" and vim.fn.isdirectory(argv) == 1 then
			vim.cmd('cd ' .. argv)
		end
	end
})

local is_wsl = vim.fn.has("wsl") == 1

if is_wsl then
	-- for wsl clipboard
	-- or see here https://www.reddit.com/r/neovim/comments/1byy8lu/copying_to_the_windows_clipboard_from_wsl2/
	-- 下面这个配置中文乱码
	-- vim.g.clipboard = {
	-- 	name = 'WslClipboard',
	-- 	copy = {
	-- 		["+"] = "clip.exe",
	-- 		["*"] = "clip.exe"
	-- 	},
	-- 	paste = {
	-- 		["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
	-- 		["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))'
	-- 	},
	-- 	cache_enabled = 0
	-- },

	-- https://www.reddit.com/r/neovim/comments/10nfjjd/how_to_install_win32yank_for_using_neovim_with_wsl/
	vim.g.clipboard = {
		name = 'WslClipboard',
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf"
		},
		paste = {
			["+"] = 'win32yank.exe -o --lf',
			["*"] = 'win32yank.exe -o --lf'
		},
		cache_enabled = 0
	}
end