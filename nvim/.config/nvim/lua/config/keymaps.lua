-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set
local floating_term = require("features.floating_term")

floating_term.setup()

local function toggle_floating_term()
  floating_term.toggle()
end

map("n", "<leader>t", toggle_floating_term, { desc = "Floating terminal (persistent)" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Leave terminal mode" })
map("i", "jj", "<Esc>", { desc = "Quick escape to normal mode" })
map("t", "jj", "<C-\\><C-n>", { desc = "Quick exit to terminal-normal mode" })

map("n", "<leader>e", function()
  require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
end, { desc = "Explorer Neo-tree (cwd)" })
