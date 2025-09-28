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
	tabstop = 4,                          -- insert 4 spaces for a tab
	cursorline = true,                    -- highlight the current line
	number = true,                        -- set numbered lines
	relativenumber = true,                -- set relative numbered lines
	numberwidth = 4,                      -- set number column width to 4 {default 4}
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

vim.opt.shortmess:append "c" -- Suppress "match x of y" messages during completion, reducing noise in the command line while you select items from the completion menu
vim.opt.shortmess:append "W" -- Stops the "written" confirmation message after `:w`, so saves happen silently unless there's an error.

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l" -- Lets the cursor wrap to the previous/next line when you move left(h) and right(l)
vim.cmd [[set iskeyword+=-]]         -- Treats the dash character as part of a "word"

-- Attempts to stop Vim's automatic comment continuation and auto-formatting:
-- - `c`: don't auto-wrap comments
-- - `r`: don't keep comment leaders when you press Enter
-- - `o`: same, when you use `o/O`
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		local fo = vim.opt_local.formatoptions
		fo:remove("c")
		fo:remove("r")
		fo:remove("o")
	end,
})

local is_wsl = vim.fn.has("wsl") == 1

if is_wsl then
	-- https://www.reddit.com/r/neovim/comments/10nfjjd/how_to_install_win32yank_for_using_neovim_with_wsl/
	vim.g.clipboard = {
		name = 'WslClipboard',
		copy = {
			["+"] = "win32yank -i --crlf",
			["*"] = "win32yank -i --crlf"
		},
		paste = {
			["+"] = 'win32yank -o --lf',
			["*"] = 'win32yank -o --lf'
		},
		cache_enabled = 0
	}
end

-- 禁用 netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 如果以目录启动，自动显示 alpha
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
			require("alpha").start()
			-- 自动将工作目录设置为打开的目录
			vim.cmd("cd " .. vim.fn.argv(0))
		end
	end
})