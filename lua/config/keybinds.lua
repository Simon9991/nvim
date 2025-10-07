local keymap = vim.keymap

vim.g.mapleader = " "

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p', { desc = "Paste from yank register" })
keymap.set("n", "<Leader>P", '"0P', { desc = "Paste before from yank register" })
keymap.set("v", "<Leader>p", '"0p', { desc = "Paste from yank register" })

-- Change operations (don't affect register)
keymap.set("n", "<Leader>c", '"_c', { desc = "Change without register" })
keymap.set("n", "<Leader>C", '"_C', { desc = "Change to EOL without register" })
keymap.set("v", "<Leader>c", '"_c', { desc = "Change without register" })
keymap.set("v", "<Leader>C", '"_C', { desc = "Change without register" })

-- Delete operations (don't affect register)
keymap.set("n", "<Leader>d", '"_d', { desc = "Delete without register" })
keymap.set("n", "<Leader>D", '"_D', { desc = "Delete to EOL without register" })
keymap.set("v", "<Leader>d", '"_d', { desc = "Delete without register" })
keymap.set("v", "<Leader>D", '"_D', { desc = "Delete without register" })

-- Move lines up/down in visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Better default behaviors
keymap.set("n", "J", "mzJ`z", { desc = "Join lines, keep cursor position" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down, center" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up, center" })
keymap.set("n", "n", "nzzzv", { desc = "Next search, center" })
keymap.set("n", "N", "Nzzzv", { desc = "Prev search, center" })

-- Make Ctrl-C behave exactly like Escape
keymap.set("i", "<C-c>", "<Esc>")

-- Quickfix navigation (moved from <C-j>/<C-k> to free them for window nav)
keymap.set("n", "<leader>cn", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
keymap.set("n", "<leader>cp", "<cmd>cprev<CR>zz", { desc = "Prev quickfix" })

-- Location list navigation
keymap.set("n", "<leader>ln", "<cmd>lnext<CR>zz", { desc = "Next location" })
keymap.set("n", "<leader>lp", "<cmd>lprev<CR>zz", { desc = "Prev location" })

-- Window navigation (your requested keybinds)
keymap.set("n", "<leader>sh", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<leader>sj", "<C-w>j", { desc = "Move to bottom window" })
keymap.set("n", "<leader>sk", "<C-w>k", { desc = "Move to top window" })
keymap.set("n", "<leader>sl", "<C-w>l", { desc = "Move to right window" })

-- Disable Ex mode
keymap.set("n", "Q", "<nop>")

-- Replace all instances of word under cursor
keymap.set("n", "<leader>s", [[:s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

-- Make file executable
keymap.set("n", "<leader>exc", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Clipboard yanking
-- Normal y/p: uses default register (clipboard if clipboard=unnamedplus is set)
-- <leader>y: forces OSC yank for SSH/remote scenarios
keymap.set("n", "<leader>Y", "<Plug>OSCYankOperator", { desc = "OSC yank (for SSH)" })
keymap.set("v", "<leader>Y", "<Plug>OSCYankVisual", { desc = "OSC yank (for SSH)" })
keymap.set("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })

-- Reload config
keymap.set("n", "<leader>rl", "<cmd>source ~/.config/nvim/init.lua<cr>", { desc = "Reload config" })

-- Undotree
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })

-- Markdown helpers
keymap.set(
	"n",
	"<leader>da",
	'<cmd>setlocal formatoptions-=a<cr><cmd>setlocal textwidth=0<cr><cmd>echo "Auto-wrapping disabled"<cr>',
	{ desc = "Disable auto wrap" }
)
keymap.set(
	"n",
	"<leader>ea",
	'<cmd>setlocal formatoptions+=a<cr><cmd>setlocal textwidth=80<cr><cmd>echo "Auto-wrapping enabled"<cr>',
	{ desc = "Enable auto wrap" }
)

keymap.set("v", "<leader>mb", "di****<esc>hhp", { desc = "Bold markdown" })
keymap.set("v", "<leader>mi", "di**<esc>hp", { desc = "Italic markdown" })
keymap.set("v", "<leader>ml", "di[]()<esc>hhhpllli", { desc = "Link markdown" })
keymap.set("v", "<leader>mc", "di``<esc>hp", { desc = "Code markdown" })

-- Oil.nvim
keymap.set("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
