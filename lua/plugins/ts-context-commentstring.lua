return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	lazy = true,
	event = "VeryLazy",
	opts = {
		enable_autocmd = false, -- We'll use it with a commenting plugin
	},
	config = function(_, opts)
		require("ts_context_commentstring").setup(opts)

		-- Integration with mini.comment or Comment.nvim
		-- For native Neovim commenting (0.10+), this is automatically used
		vim.g.skip_ts_context_commentstring_module = true
	end,
}
