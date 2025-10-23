return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		theme = "tokyonight",
		show_dirname = true,
		show_basename = true,
		show_modified = true,
		modified = function(bufnr)
			return vim.bo[bufnr].modified
		end,
		exclude_filetypes = { "netrw", "toggleterm", "Trouble", "trouble" },
		show_navic = true,
		attach_navic = false, -- We attach navic manually in lsp.lua
		lead_custom_section = function()
			return " "
		end,
		custom_section = function()
			return ""
		end,
		context_follow_icon_color = false,
		symbols = {
			modified = "●",
			ellipsis = "…",
			separator = "",
		},
		kinds = {
			File = " ",
			Module = " ",
			Namespace = "󰌗 ",
			Package = " ",
			Class = "󰌗 ",
			Method = "󰆧 ",
			Property = " ",
			Field = " ",
			Constructor = " ",
			Enum = "󰕘 ",
			Interface = "󰕘 ",
			Function = "󰊕 ",
			Variable = "󰆧 ",
			Constant = "󰏿 ",
			String = " ",
			Number = "󰎠 ",
			Boolean = "◩ ",
			Array = "󰅪 ",
			Object = "󰅩 ",
			Key = "󰌋 ",
			Null = "󰟢 ",
			EnumMember = " ",
			Struct = "󰌗 ",
			Event = " ",
			Operator = "󰆕 ",
			TypeParameter = "󰊄 ",
		},
	},
}
