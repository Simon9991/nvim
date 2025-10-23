return {
	"aznhe21/actions-preview.nvim",
	keys = {
		{
			"<leader>ca",
			function()
				require("actions-preview").code_actions()
			end,
			mode = { "v", "n" },
			desc = "Code actions (preview)",
		},
	},
	config = function()
		require("actions-preview").setup({
			backend = { "telescope" },
			telescope = require("telescope.themes").get_dropdown({
				winblend = 10,
				layout_config = {
					width = 0.8,
					height = 0.8,
				},
			}),
			diff = {
				algorithm = "patience",
				ignore_whitespace = true,
			},
			highlight_command = {
				require("actions-preview.highlight").delta(),
			},
		})
	end,
}
