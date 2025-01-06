return {
  "buoto/gotests-vim",
  keys = {
    { "<leader>tg", "<cmd>GoTests<CR>", desc = "Generate go unit tests for target function" },
    { "<leader>tG", "<cmd>GoTestsAll<CR>", desc = "Generate go unit tests for all functions in the file." },
  },
  config = function()
    -- vim.g.gotests_template_dir = "/Users/alan.tai/go/templates/"
  end,
}
