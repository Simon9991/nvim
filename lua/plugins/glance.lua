return {
	"dnlhc/glance.nvim",
	cmd = { "Glance" },
	keys = {
		{ "gd", "<cmd>Glance definitions<CR>", desc = "Glance definitions" },
		{ "gr", "<cmd>Glance references<CR>", desc = "Glance references" },
		{ "gy", "<cmd>Glance type_definitions<CR>", desc = "Glance type definitions" },
		{ "gi", "<cmd>Glance implementations<CR>", desc = "Glance implementations" },
	},
	config = function()
		local actions = require("glance").actions

		require("glance").setup({
			height = 18,
			zindex = 45,
			border = {
				enable = true,
				top_char = "―",
				bottom_char = "―",
			},
			list = {
				position = "right",
				width = 0.33,
			},
			theme = {
				enable = true,
				mode = "auto",
			},
			mappings = {
				list = {
					["j"] = actions.next,
					["k"] = actions.previous,
					["<Down>"] = actions.next,
					["<Up>"] = actions.previous,
					["<Tab>"] = actions.next_location,
					["<S-Tab>"] = actions.previous_location,
					["<C-u>"] = actions.preview_scroll_win(5),
					["<C-d>"] = actions.preview_scroll_win(-5),
					["v"] = actions.jump_vsplit,
					["s"] = actions.jump_split,
					["t"] = actions.jump_tab,
					["<CR>"] = actions.jump,
					["o"] = actions.jump,
					["<leader>l"] = actions.enter_win("preview"),
					["q"] = actions.close,
					["Q"] = actions.close,
					["<Esc>"] = actions.close,
				},
				preview = {
					["Q"] = actions.close,
					["<Tab>"] = actions.next_location,
					["<S-Tab>"] = actions.previous_location,
					["<leader>l"] = actions.enter_win("list"),
				},
			},
			hooks = {},
			folds = {
				fold_closed = "",
				fold_open = "",
				folded = true,
			},
			indent_lines = {
				enable = true,
				icon = "│",
			},
			winbar = {
				enable = true,
			},
		})
	end,
}
