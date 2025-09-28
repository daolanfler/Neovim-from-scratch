---@diagnostic disable: undefined-global

local JQ_THRESHOLD_BYTES = 256 * 1024 -- 256 KB
local JQ_THRESHOLD_LINES = 2000

local function should_use_jq(bufnr)
	if vim.bo[bufnr].filetype ~= "json" then
		return false
	end
	if vim.fn.executable("jq") ~= 1 then
		return false
	end

	local name = vim.api.nvim_buf_get_name(bufnr)
	if name ~= "" then
		local size = vim.fn.getfsize(name)
		if size >= 0 then
			return size >= JQ_THRESHOLD_BYTES
		end
	end

	return vim.api.nvim_buf_line_count(bufnr) >= JQ_THRESHOLD_LINES
end

local function format_json_with_jq(bufnr)
	local input = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n") .. "\n"
	local output = vim.fn.systemlist({ "jq", "." }, input)
	if vim.v.shell_error ~= 0 then
		vim.notify(table.concat(output, "\n"), vim.log.levels.ERROR, { title = "jq format" })
		return false
	end
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output)
	return true
end

local function format_with_lsp()
	local view = vim.fn.winsaveview()
	vim.lsp.buf.format({ async = false })
	vim.fn.winrestview(view)
end

vim.api.nvim_create_user_command("Format", function()
	local bufnr = vim.api.nvim_get_current_buf()
	if should_use_jq(bufnr) then
		local view = vim.fn.winsaveview()
		local ok = format_json_with_jq(bufnr)
		vim.fn.winrestview(view)
		if ok then
			return
		end
	end
	format_with_lsp()
end, {
	desc = "Format current buffer"
})

local M = {}

-- TODO: backfill this to template
M.setup = function()
	local signs = { {
		name = "DiagnosticSignError",
		text = ""
	}, {
		name = "DiagnosticSignWarn",
		text = ""
	}, {
		name = "DiagnosticSignHint",
		text = ""
	}, {
		name = "DiagnosticSignInfo",
		text = ""
	} }

	-- for _, sign in ipairs(signs) do
	-- 	vim.fn.sign_define(sign.name, {
	-- 		texthl = sign.name,
	-- 		text = sign.text,
	-- 		numhl = ""
	-- 	})
	-- end

	local config = {
		-- enable virtual text
		virtual_text = true,
		-- show signs
		signs = {
			active = signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = ""
		}
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded"
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded"
	})
	vim.lsp.inlay_hint.enable(true)
end

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.document_highlight then
		vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
	end
end

local function lsp_keymaps(bufnr)
	local opts = {
		noremap = true,
		silent = true
	}
	-- TODO https://youtu.be/stqUbv-5u2s?t=865 refactor these keymaps in buffer
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", ":Lspsaga goto_definition<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", ":Lspsaga hover_doc<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", ":Lspsaga rename<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":Lspsaga finder<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", ":Lspsaga code_action<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", ":Lspsaga show_line_diagnostics<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", ":Lspsaga diagnostic_jump_next<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.document_formatting = false
	end
	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M