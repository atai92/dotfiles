return {
  "buoto/gotests-vim",
  keys = {
    { "<leader>tg", "<cmd>GoTests<CR>", desc = "Generate go unit tests for target function" },
    { "<leader>tG", "<cmd>GoTestsAll<CR>", desc = "Generate go unit tests for all functions in the file." },
  },
  config = function()
    require("gotests-vim").setup()
  end,
}
