-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>ct", "<cmd>TroubleToggle<cr>", { desc = "Show all issues within project." })

vim.keymap.set("v", "<PageDown>", ":m '>+1<CR>gv=gv", { desc = "Move the current line down." })
vim.keymap.set("v", "<PageUp>", ":m '<-2<CR>gv=gv", { desc = "Move the current line up." })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selection" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "De-indent selection" })

-- Git keymaps
vim.keymap.set("n", "<leader>gC", "<cmd>Telescope git_commits<cr>", { desc = "Show all commits within Telescope." })

vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume the last telescope session." }
)

vim.keymap.set("n", "<leader>n", function()
  require("telescope").load_extension("notify")
  require("telescope").extensions.notify.notify()
end, { desc = "Show notifications history in telescope." })

vim.keymap.set(
  "n",
  "<leader>y",
  "<CMD>let @+ = expand('%:')<CR>",
  { desc = "Copy the current file's relative path to the clipboard." }
)

vim.keymap.set(
  "n",
  "<leader>Y",
  "<CMD>let @+ = expand('%:p')<CR>",
  { desc = "Copy the current file's absolute path to the clipboard." }
)

vim.keymap.set(
  "n",
  "<leader>sr",
  "<CMD>lua require('telescope.builtin').registers()<CR>",
  { desc = "Search through registers." }
)

vim.keymap.set(
  "n",
  "<leader>be",
  "<CMD>lua require('telescope.builtin').buffers()<CR>",
  { desc = "Search through buffers." }
)

vim.keymap.set("n", "<a-left>", "b", { desc = "jump to beginning of word." })
vim.keymap.set("n", "<a-right>", "e", { desc = "jump to end of word." })
vim.keymap.set("i", "<a-left>", "<c-o>b", { desc = "jump to beginning of word." })
vim.keymap.set("i", "<a-right>", "<c-o>e", { desc = "jump to end of word." })

vim.keymap.set("n", "<c-s-/>", ":terminal<cr>", { desc = "Open terminal in a new buffer." })
