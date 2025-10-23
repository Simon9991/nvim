return {
	"mechatroner/rainbow_csv",
	ft = { "csv", "tsv", "csv_semicolon", "csv_whitespace", "csv_pipe", "rfc_csv", "rfc_semicolon" },
	cmd = {
		"RainbowDelim",
		"RainbowDelimSimple",
		"RainbowDelimQuoted",
		"RainbowMultiDelim",
	},
	config = function()
		-- Plugin works out of the box, no setup needed
		-- Commands available:
		-- :RainbowDelim - Manually select delimiter
		-- :RainbowMultiDelim - Multi-character delimiter
		-- :Select ... - RBQL queries (SQL-like)
		-- :RainbowAlign - Align columns
	end,
}
