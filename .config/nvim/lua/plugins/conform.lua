return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      scala = { "scalafmt" },
      go = {
        "goimports-reviser",
        "gofumpt",
      },
    },
  },
}
