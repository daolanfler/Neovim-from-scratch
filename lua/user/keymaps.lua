---@diagnostic disable-next-line: undefined-global
local vim = vim

local opts = {
	noremap = true,
	silent = true
}

---@diagnostic disable-next-line: unused-local
local term_opts = {
	silent = true
}

local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

local comment_api
local comment_api_notified = false

local function get_comment_api()
	if comment_api ~= nil then
		return comment_api
	end
	local ok, api = pcall(require, "Comment.api")
	if ok then
		comment_api = api
		return comment_api
	end
	if not comment_api_notified then
		vim.notify("Comment.nvim not available", vim.log.levels.WARN, { title = "Keymaps" })
		comment_api_notified = true
	end
	return nil
end

local function toggle_comment_linewise()
	local api = get_comment_api()
	if not api then
		return
	end
	api.toggle.linewise.current()
end

local function toggle_comment_visual()
	local api = get_comment_api()
	if not api then
		return
	end
	vim.api.nvim_feedkeys(esc, 'nx', false)
	api.toggle.linewise(vim.fn.visualmode())
end

-- Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
vim.keymap.set("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
vim.keymap.set("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)

-- Better copy paste
vim.keymap.set("n", "<leader>x", "\"_x", opts)
vim.keymap.set("n", "<leader>s", "\"_s", opts)
vim.keymap.set("n", "<leader>d", "\"_d", opts)
vim.keymap.set("n", "<leader>c", "\"_c", opts)
vim.keymap.set("n", "<leader>y", "\"+y", opts)

-- Insert --
-- Press jk fast to enter
vim.keymap.set("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Better copy paste
vim.keymap.set("v", "<leader>d", "\"_d", opts)
vim.keymap.set("v", "<leader>c", "\"_c", opts)
vim.keymap.set("v", "<leader>p", "\"_dP", opts)
vim.keymap.set("v", "<leader>y", "\"+y", opts)
-- vim.keymap.set("v", "p", '"_dP', opts)

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)

-- Visual Block --
-- Move text up and down
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- VS Code style comment toggles
vim.keymap.set("n", "<C-_>", toggle_comment_linewise, opts)
vim.keymap.set("n", "<C-/>", toggle_comment_linewise, opts)
vim.keymap.set("n", "<D-_>", toggle_comment_linewise, opts)
vim.keymap.set("n", "<D-/>", toggle_comment_linewise, opts)

vim.keymap.set("x", "<C-_>", toggle_comment_visual, opts)
vim.keymap.set("x", "<C-/>", toggle_comment_visual, opts)
vim.keymap.set("x", "<D-_>", toggle_comment_visual, opts)
vim.keymap.set("x", "<D-/>", toggle_comment_visual, opts)

vim.keymap.set("n", "<leader>f", ":Format<CR>", opts)
vim.keymap.set("i", "<C-l>", "<C-o>$", { noremap = true, silent = true })
