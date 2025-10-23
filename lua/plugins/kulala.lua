return {
	"mistweaverco/kulala.nvim",
	ft = { "http", "rest" },
	keys = {
		{ "<leader>Rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send HTTP request" },
		{ "<leader>Ri", "<cmd>lua require('kulala').inspect()<cr>", desc = "Inspect request" },
		{ "<leader>Rc", "<cmd>lua require('kulala').copy()<cr>", desc = "Copy request as cURL" },
		{ "<leader>Rt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle view" },
		{ "<leader>Rj", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request" },
		{ "<leader>Rk", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Jump to previous request" },
	},
	opts = {
		default_view = "body", -- "body" or "headers"
		split_direction = "vertical", -- "vertical" or "horizontal"
		-- Additional configuration options
		curl_options = {
			-- Add any default curl options here
		},
	},
}
