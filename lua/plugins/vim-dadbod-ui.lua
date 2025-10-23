return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	keys = {
		{ "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle DBUI" },
		{ "<leader>dba", "<cmd>DBUIAddConnection<cr>", desc = "Add DB connection" },
		{ "<leader>dbf", "<cmd>DBUIFindBuffer<cr>", desc = "Find DB buffer" },
	},
	init = function()
		-- Use nerd fonts
		vim.g.db_ui_use_nerd_fonts = 1

		-- Auto-execute table helpers (optional)
		vim.g.db_ui_auto_execute_table_helpers = 1

		-- Default DB drawer width
		vim.g.db_ui_winwidth = 30

		-- Show database details in statusline
		vim.g.db_ui_show_database_icon = 1

		-- Table helpers (top 10 rows, etc.)
		vim.g.db_ui_table_helpers = {
			postgresql = {
				Count = "select count(*) from {optional_schema}{table}",
				Explain = "explain analyze {last_query}",
			},
			mysql = {
				Count = "select count(*) from {table}",
				Explain = "explain {last_query}",
			},
		}

		-- Save DB connections (example - add your own in init.lua or environment variables)
		-- vim.g.dbs = {
		--   dev = 'postgresql://user:password@localhost:5432/mydb',
		--   staging = 'postgresql://user:password@staging:5432/mydb',
		-- }
	end,
}
