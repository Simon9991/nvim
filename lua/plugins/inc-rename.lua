return {
	"smjonas/inc-rename.nvim",
	cmd = "IncRename",
	keys = {
		{
			"<F2>",
			function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end,
			expr = true,
			desc = "Incremental rename",
		},
	},
	opts = {
		input_buffer_type = "dressing",
	},
}
