return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>fmt",
			function()
				require("conform").format({
					async = true,
					lsp_format = "never",
					stop_after_first = true,
				})
			end,
			mode = { "n", "x" },
			desc = "Format buffer",
		},
	},
	opts = function()
		return {
			notify_on_error = false,

			format_on_save = function()
				return {
					timeout_ms = 500,
					lsp_format = "never",
					stop_after_first = true,
				}
			end,

			-- Try Biome first, then Prettier as fallback
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				svelte = { "prettier" },
				go = { "goimports", "gofmt" },
				rust = { "rustfmt" },
				cs = { "csharpier" },
			},

			formatters = {
				prettier = {
					prefer_local = "node_modules/.bin",
				},
			},
		}
	end,
}
