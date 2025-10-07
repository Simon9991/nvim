return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 300,
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				-- Navigation
				vim.keymap.set("n", "]c", gs.next_hunk, { buffer = bufnr })
				vim.keymap.set("n", "[c", gs.prev_hunk, { buffer = bufnr })

				-- Actions
				vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr })
				vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr })
				vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr })
				vim.keymap.set("n", "<leader>hb", gs.blame_line, { buffer = bufnr })
				vim.keymap.set("n", "<leader>hd", gs.diffthis, { buffer = bufnr })
				vim.keymap.set("n", "<leader>tw", gs.toggle_word_diff, { buffer = bufnr })
			end,
		},
	},
}
