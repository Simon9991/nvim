return {
	"uga-rosa/ccc.nvim",
	cmd = { "CccPick", "CccConvert", "CccHighlighterEnable", "CccHighlighterDisable", "CccHighlighterToggle" },
	keys = {
		{ "<leader>cp", "<cmd>CccPick<cr>", desc = "Color picker" },
		{ "<leader>cc", "<cmd>CccConvert<cr>", desc = "Convert color" },
		{ "<leader>ch", "<cmd>CccHighlighterToggle<cr>", desc = "Toggle color highlighter" },
	},
	config = function()
		local ccc = require("ccc")
		ccc.setup({
			highlighter = {
				auto_enable = true,
				lsp = true,
				filetypes = {
					"css",
					"scss",
					"sass",
					"html",
					"javascript",
					"typescript",
					"typescriptreact",
					"javascriptreact",
					"svelte",
					"vue",
				},
			},
			pickers = {
				ccc.picker.hex,
				ccc.picker.css_rgb,
				ccc.picker.css_hsl,
				ccc.picker.css_hwb,
				ccc.picker.css_lab,
				ccc.picker.css_lch,
				ccc.picker.css_oklab,
				ccc.picker.css_oklch,
			},
			outputs = {
				ccc.output.hex,
				ccc.output.css_rgb,
				ccc.output.css_hsl,
			},
			alpha_show = "auto",
			recognition = {
				filetypes = {},
				pattern = [=[\v\c<#(\x\x)(\x\x)(\x\x)(\x\x)?>|<#(\x\x\x)>|rgb\(\s*(\d+%?)\s*,\s*(\d+%?)\s*,\s*(\d+%?)\s*\)|hsl\(\s*(\d+%?)\s*,\s*(\d+%?)\s*,\s*(\d+%?)\s*\)]=],
			},
		})
	end,
}
