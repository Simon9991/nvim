return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		delay = 400, -- delay before showing which-key popup (ms)
		plugins = {
			marks = true, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = {
				enabled = true, -- show spelling suggestions with z=
				suggestions = 20,
			},
			presets = {
				operators = true, -- adds help for operators like d, y, c, etc
				motions = true, -- adds help for motions
				text_objects = true, -- help for text objects triggered after entering an operator
				windows = true, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},
		win = {
			border = "rounded",
			padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
		},
		layout = {
			height = { min = 4, max = 25 },
			width = { min = 20, max = 50 },
			spacing = 3,
			align = "left",
		},
		show_help = true, -- show help message on the command line when the popup is visible
		show_keys = true, -- show the currently pressed key and its label as a message in the command line
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer keymaps (which-key)",
		},
	},
}
