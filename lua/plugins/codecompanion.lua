return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
    },
    opts = {
        strategies = {
            chat = {
                adapter = "anthropic",
                model = "claude-sonnet-4-5-20250929",
            },
            inline = {
                adapter = "anthropic",
            },
        },
        opts = {
            log_level = "DEBUG",
        },
    },
    keys = {
        { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle Chat" },
        { "<leader>ci", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Actions" },
        { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to Chat" },
    },
}
