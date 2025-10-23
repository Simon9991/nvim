return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	keys = {
		{
			"<leader>un",
			function()
				require("notify").dismiss({ silent = true, pending = true })
			end,
			desc = "Dismiss notifications",
		},
		{
			"<leader>nh",
			function()
				require("telescope").extensions.notify.notify()
			end,
			desc = "Notification history",
		},
	},
	opts = {
		timeout = 3000,
		max_height = function()
			return math.floor(vim.o.lines * 0.75)
		end,
		max_width = function()
			return math.floor(vim.o.columns * 0.75)
		end,
		on_open = function(win)
			vim.api.nvim_win_set_config(win, { zindex = 100 })
		end,
		render = "compact", -- "default", "minimal", "simple", "compact", "wrapped-compact"
		stages = "fade_in_slide_out", -- Animation style
		top_down = false, -- Show from bottom
	},
	config = function(_, opts)
		local notify = require("notify")
		notify.setup(opts)
		-- Set as default notify
		vim.notify = notify
	end,
}
