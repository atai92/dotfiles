return {
  "tpope/vim-fugitive",
  keys = {
    { "<leader>gc", "<cmd>Git commit<cr>", desc = "Commit changes.", mode = "n" },
    { "<leader>ga", "<cmd>Git add .<cr>", desc = "Add all changes to git.", mode = "n" },
    { "<leader>gp", "<cmd>Git pull<cr>", desc = "Pull changes from git.", mode = "n" },
    { "<leader>gP", "<cmd>Git push<cr>", desc = "Push changes to git.", mode = "n" },
  },
  config = function()
    vim.keymap.del("n", "<leader>gc")
  end,
}
