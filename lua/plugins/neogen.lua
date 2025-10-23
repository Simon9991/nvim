return {
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	cmd = "Neogen",
	keys = {
		{ "<leader>nf", function() require("neogen").generate() end, desc = "Generate docstring" },
		{ "<leader>nc", function() require("neogen").generate({ type = "class" }) end, desc = "Generate class doc" },
		{ "<leader>nt", function() require("neogen").generate({ type = "type" }) end, desc = "Generate type doc" },
		{ "<leader>nF", function() require("neogen").generate({ type = "file" }) end, desc = "Generate file doc" },
	},
	opts = {
		enabled = true,
		input_after_comment = true,
		snippet_engine = "luasnip",
		languages = {
			lua = {
				template = {
					annotation_convention = "ldoc",
				},
			},
			typescript = {
				template = {
					annotation_convention = "tsdoc",
				},
			},
			typescriptreact = {
				template = {
					annotation_convention = "tsdoc",
				},
			},
			javascript = {
				template = {
					annotation_convention = "jsdoc",
				},
			},
			javascriptreact = {
				template = {
					annotation_convention = "jsdoc",
				},
			},
			python = {
				template = {
					annotation_convention = "google_docstrings",
				},
			},
			rust = {
				template = {
					annotation_convention = "rustdoc",
				},
			},
			go = {
				template = {
					annotation_convention = "godoc",
				},
			},
			c = {
				template = {
					annotation_convention = "doxygen",
				},
			},
			cpp = {
				template = {
					annotation_convention = "doxygen",
				},
			},
			cs = {
				template = {
					annotation_convention = "xmldoc",
				},
			},
		},
	},
}
