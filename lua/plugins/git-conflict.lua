return {
	"akinsho/git-conflict.nvim",
	version = "*",
	event = "BufReadPost",
	opts = {
		default_mappings = true, -- Enable buffer local mapping
		default_commands = true, -- Enable commands
		disable_diagnostics = false, -- Keep diagnostics
		list_opener = "copen", -- Command to open list of conflicts
		highlights = {
			incoming = "DiffAdd",
			current = "DiffText",
		},
	},
	config = function(_, opts)
		require("git-conflict").setup(opts)

		-- Keybind hints for reference (default_mappings = true enables these):
		-- co — choose ours
		-- ct — choose theirs
		-- cb — choose both
		-- c0 — choose none
		-- ]x — move to next conflict
		-- [x — move to previous conflict
	end,
}
