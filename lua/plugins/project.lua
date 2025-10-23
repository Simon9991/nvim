return {
	"ahmedkhalf/project.nvim",
	name = "project_nvim",
	event = "VeryLazy",
	keys = {
		{ "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Find projects" },
	},
	opts = {
		manual_mode = false,
		detection_methods = { "lsp", "pattern" },
		patterns = {
			".git",
			"_darcs",
			".hg",
			".bzr",
			".svn",
			"Makefile",
			"package.json",
			"Cargo.toml",
			"go.mod",
			"pyproject.toml",
			"setup.py",
			"flake.nix",
			"default.nix",
		},
		ignore_lsp = {},
		exclude_dirs = {},
		show_hidden = false,
		silent_chdir = true,
		scope_chdir = "global",
		datapath = vim.fn.stdpath("data"),
	},
	config = function(_, opts)
		require("project_nvim").setup(opts)
		require("telescope").load_extension("projects")
	end,
}
