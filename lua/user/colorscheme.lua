-- Colorschemes, picked automatically from the terminal's background color:
--   dark terminal  -> darkplus (the original theme)
--   light terminal -> Catppuccin Latte
local schemes = {
	dark = "darkplus",
	light = "catppuccin-latte",
}

local M = {}

local group = vim.api.nvim_create_augroup("UserAutoTheme", { clear = true })

local current = nil

-- Extra highlights applied on top of whichever colorscheme is active
local function apply_overrides()
	vim.api.nvim_set_hl(0, "Normal", {
		bg = "none"
	});
	vim.api.nvim_set_hl(0, "NormalFloat", {
		bg = "none"
	});

	-- the message / `cmdline` row: colorschemes paint it with a solid
	-- background, which shows up as a band next to a transparent `Normal`
	vim.api.nvim_set_hl(0, "MsgArea", {
		bg = "none"
	});

	-- windows terminal does have great support for italic chinese characters rendering
	if vim.fn.has("wsl") == 1 then
		vim.api.nvim_set_hl(0, "Comment", {
			fg = "#808080",
			italic = false
		})
	end
end

--- Apply the colorscheme matching the terminal background.
--- @param mode "dark"|"light"
function M.apply(mode)
	mode = mode == "light" and "light" or "dark"

	if current == mode and vim.g.colors_name == schemes[mode] then
		return
	end

	-- Drop the previous scheme explicitly: changing 'background' makes Nvim
	-- forget g:colors_name, and catppuccin only clears highlights while it is
	-- set, so groups the light theme does not define (e.g. `MsgArea`) would
	-- keep the dark colors.
	vim.g.colors_name = nil
	vim.cmd("highlight clear")

	-- `background` has to be in place before the colorscheme is loaded,
	-- some colorschemes (and lualine themes) look at it while loading.
	if vim.o.background ~= mode then
		vim.o.background = mode
	end

	local ok = pcall(vim.cmd.colorscheme, schemes[mode])
	if not ok then
		-- Theme not available (e.g. catppuccin not installed yet), stay dark
		mode = "dark"
		pcall(vim.cmd.colorscheme, schemes.dark)
	end

	current = mode
	apply_overrides()
end

--- @return "dark"|"light"|nil
function M.current()
	return current
end

-- Keep the old helper around, it is handy for poking at themes by hand
function ColorMyPencils(color)
	M.apply(color == schemes.light and "light" or "dark")
end

-- Terminal background detection ----------------------------------------------

--- Turn an OSC 11 reply (e.g. "\27]11;rgb:eff1/eff1/eff1") into a background mode.
--- @param sequence string
--- @return "dark"|"light"|nil
local function mode_from_osc11(sequence)
	local r, g, b = sequence:match("^\27%]11;rgb:(%x+)/(%x+)/(%x+)$")
	if not r then
		local a
		r, g, b, a = sequence:match("^\27%]11;rgba:(%x+)/(%x+)/(%x+)/(%x+)$")
		if not a or #a > 4 then
			return nil
		end
	end
	if not (r and g and b and #r <= 4 and #g <= 4 and #b <= 4) then
		return nil
	end

	local function channel(hex)
		local max = tonumber(string.rep("f", #hex), 16)
		return max == 0 and 0 or tonumber(hex, 16) / max
	end

	-- same luminance formula Neovim uses to set 'background'
	local luminance = 0.299 * channel(r) + 0.587 * channel(g) + 0.114 * channel(b)
	return luminance < 0.5 and "dark" or "light"
end

-- Start dark (the theme used so far); the terminal's answer below corrects it
-- within the first few milliseconds of startup.
M.apply("dark")

vim.api.nvim_create_autocmd("TermResponse", {
	group = group,
	desc = "Switch colorscheme when the terminal background color changes",
	callback = function(args)
		local mode = mode_from_osc11(args.data.sequence)
		if mode then
			-- color schemes should not be loaded from a TermResponse callback
			vim.schedule(function()
				M.apply(mode)
			end)
		end
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	group = group,
	callback = apply_overrides,
})

--- Write a control sequence to the terminal (only when we own a real tty).
--- @param sequence string
local function write_to_term(sequence)
	local ui = vim.api.nvim_list_uis()[1]
	if ui and ui.stdout_tty then
		io.stdout:write(sequence)
		io.stdout:flush()
	end
end

-- Ask the terminal for its background color and subscribe to theme updates
-- (DEC mode 2031, supported by Ghostty/iTerm2/WezTerm/kitty/...).
-- Neovim also does the OSC 11 query on its own at startup.
write_to_term("\27]11;?\7")
write_to_term("\27[?2031h")

-- Stop the theme notifications again, otherwise a theme switch after leaving
-- Neovim would print escape sequences into the shell.
vim.api.nvim_create_autocmd("VimLeavePre", {
	group = group,
	callback = function()
		write_to_term("\27[?2031l")
	end,
})

vim.api.nvim_create_user_command("Theme", function(opts)
	M.apply(opts.args)
end, {
	nargs = 1,
	complete = function()
		return { "light", "dark" }
	end,
	desc = "Apply a colorscheme by hand (`:Theme light|dark`)",
})

return M
