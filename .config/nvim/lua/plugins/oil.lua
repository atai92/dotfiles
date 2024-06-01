return {
  "stevearc/oil.nvim",
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "-",
      function()
        require("oil").open_float()
      end,
      desc = "Open oil, the file explorer",
    },
    {
      "<leader>e",
      "<cmd>lua require('oil').open_float()<cr>",
      { noremap = true, silent = true, desc = "Open oil, the file explorer" },
    },
  },
  buf_options = {
    buflisted = true,
  },
  opts = {
    default_file_explorer = true,
    columns = {
      "icon",
      "permissions",
      "size",
      "mtime",
    },
    view_options = {
      show_hidden = true,
      natural_order = false,
    },
    float = {
      padding = 1,
      max_width = 180,
      max_height = 48,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
      override = function(conf)
        return conf
      end,
    },
    preview = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = 0.9,
      min_height = { 5, 0.1 },
      height = nil,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },
  },
}
