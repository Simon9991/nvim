return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		{ "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal", mode = { "n", "t" } },
		{ "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },
		{ "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle horizontal terminal" },
		{ "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Toggle vertical terminal" },
	},
	opts = {
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		open_mapping = [[<C-\>]],
		hide_numbers = true,
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = true, -- <C-\> works in insert mode
		terminal_mappings = true, -- <C-\> works in terminal mode
		persist_size = true,
		persist_mode = true, -- remember previous terminal mode
		direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
		close_on_exit = true,
		shell = vim.o.shell,
		auto_scroll = true,
		float_opts = {
			border = "curved", -- 'single' | 'double' | 'shadow' | 'curved'
			width = function()
				return math.floor(vim.o.columns * 0.9)
			end,
			height = function()
				return math.floor(vim.o.lines * 0.9)
			end,
			winblend = 0,
		},
		winbar = {
			enabled = false,
			name_formatter = function(term)
				return term.name
			end,
		},
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		-- Terminal keymaps for better navigation
		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
		end

		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
