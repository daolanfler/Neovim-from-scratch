-- 使用 rustup component 中的  rust-analyzer
local opts = {
	cmd = { "rustup", "run", "stable", "rust-analyzer" }
}

return opts