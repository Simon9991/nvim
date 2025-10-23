return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	keys = {
		{
			"<leader>qs",
			function()
				require("persistence").load()
			end,
			desc = "Restore session for current dir",
		},
		{
			"<leader>qS",
			function()
				require("persistence").select()
			end,
			desc = "Select session to load",
		},
		{
			"<leader>ql",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Restore last session",
		},
		{
			"<leader>qd",
			function()
				require("persistence").stop()
			end,
			desc = "Don't save current session",
		},
	},
	opts = {
		dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
		-- Options for `:mksession`
		options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" },
		pre_save = nil,
		save_empty = false,
	},
}
