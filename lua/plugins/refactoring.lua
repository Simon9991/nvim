return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        { "<leader>re",  ":Refactor extract ",                  mode = "x",          desc = "Extract function" },
        { "<leader>rf",  ":Refactor extract_to_file ",          mode = "x",          desc = "Extract to file" },
        { "<leader>rv",  ":Refactor extract_var ",              mode = "x",          desc = "Extract variable" },
        { "<leader>ri",  ":Refactor inline_var<CR>",            mode = { "n", "x" }, desc = "Inline variable" },
        { "<leader>rI",  ":Refactor inline_func<CR>",           mode = "n",          desc = "Inline function" },
        { "<leader>rb",  ":Refactor extract_block<CR>",         mode = "n",          desc = "Extract block" },
        { "<leader>rbf", ":Refactor extract_block_to_file<CR>", mode = "n",          desc = "Extract block to file" },
    },
    opts = {},
}
