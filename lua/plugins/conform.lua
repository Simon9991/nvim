return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>F3",
			function()
				require("conform").format({
					async = true,
					lsp_format = "never",
					stop_after_first = true, -- <— new way
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
					timeout_ms = 2000,
					lsp_format = "never",
					stop_after_first = true, -- only one formatter runs
				}
			end,

			-- Try Biome first, then Prettier as fallback
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "biome", "prettier" },
				javascriptreact = { "biome", "prettier" },
				typescript = { "biome", "prettier" },
				typescriptreact = { "biome", "prettier" }, -- TSX
				json = { "biome", "prettier" },
				jsonc = { "biome", "prettier" },
				svelte = { "prettier" },
				go = { "goimports", "gofmt" },
				rust = { "rustfmt" },
			},

			formatters = {
				biome = {
					command = "biome",
					args = { "format", "--stdin-file-path", "$FILENAME" }, -- same as `biome format --write`
					stdin = true,
					prefer_local = "node_modules/.bin", -- uses project’s Biome if present
					-- NOTE: no `cwd` and no `condition` — let Biome discover biome.json(c) itself
				},
				prettier = {
					prefer_local = "node_modules/.bin",
				},
			},
		}
	end,
}
