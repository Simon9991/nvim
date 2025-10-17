return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	lazy = false,
	ft = { "rust" },
	opts = {
		server = {
			on_attach = function(client, bufnr)
				-- Disable rust-analyzer's built-in formatting since you're using rustfmt via conform
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end,
			default_settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
						loadOutDirsFromCheck = true,
						buildScripts = {
							enable = true,
						},
					},
					checkOnSave = {
						command = "clippy",
						allFeatures = true,
					},
					procMacro = {
						enable = true,
						ignored = {
							["async-trait"] = { "async_trait" },
							["napi-derive"] = { "napi" },
							["async-recursion"] = { "async_recursion" },
						},
					},
					inlayHints = {
						lifetimeElisionHints = {
							enable = "always",
						},
					},
				},
			},
		},
		-- DAP configuration (integrates with nvim-dap)
		dap = {
			adapter = {
				type = "executable",
				command = "codelldb",
				name = "rt_lldb",
			},
		},
	},
	config = function(_, opts)
		vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
	end,
}
