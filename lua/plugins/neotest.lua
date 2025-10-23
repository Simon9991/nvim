return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- Language adapters
		"nvim-neotest/neotest-go",
		"rouge8/neotest-rust",
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-jest",
		"marilari88/neotest-vitest",
	},
	keys = {
		{ "<leader>tn", function() require("neotest").run.run() end, desc = "Run nearest test" },
		{ "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run current file" },
		{ "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
		{ "<leader>ts", function() require("neotest").run.stop() end, desc = "Stop test" },
		{ "<leader>ta", function() require("neotest").run.attach() end, desc = "Attach to test" },
		{ "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Show test output" },
		{ "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
		{ "<leader>tt", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
		{
			"[t",
			function()
				require("neotest").jump.prev({ status = "failed" })
			end,
			desc = "Previous failed test",
		},
		{
			"]t",
			function()
				require("neotest").jump.next({ status = "failed" })
			end,
			desc = "Next failed test",
		},
	},
	config = function()
		require("neotest").setup({
			adapters = {
				-- Go tests
				require("neotest-go")({
					args = { "-count=1", "-timeout=60s" },
				}),
				-- Rust tests
				require("neotest-rust")({
					args = { "--no-capture" },
					dap_adapter = "codelldb",
				}),
				-- Python tests
				require("neotest-python")({
					dap = { justMyCode = false },
					args = { "--log-level", "DEBUG", "--quiet" },
					runner = "pytest",
				}),
				-- JavaScript/TypeScript tests (Jest)
				require("neotest-jest")({
					jestCommand = "npm test --",
					jestConfigFile = "custom.jest.config.ts",
					env = { CI = true },
					cwd = function()
						return vim.fn.getcwd()
					end,
				}),
				-- Vitest
				require("neotest-vitest"),
			},
			-- Customize icons
			icons = {
				running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
			},
			-- Diagnostic configuration
			diagnostic = {
				enabled = true,
				severity = vim.diagnostic.severity.ERROR,
			},
			-- Floating window options
			floating = {
				border = "rounded",
				max_height = 0.8,
				max_width = 0.9,
			},
			-- Summary window options
			summary = {
				open = "botright vsplit | vertical resize 50",
			},
		})
	end,
}
