local neotest = require("neotest")

local function run_tests_open_summary()
  neotest.run.run(vim.fn.expand("%"))
  neotest.summary.open()
end

return {
  "nvim-neotest/neotest",
  dependencies = {
    "fredrikaverpil/neotest-golang",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
  },

  opts = {
    adapters = { "neotest-golang" },
    output = {
      virtual_text = true,
    },
  },

  keys = {
    {
      "<leader>tF",
      function()
        neotest.run.run(vim.loop.cwd())
      end,
      desc = "Run All Test Files",
    },
    {
      "<leader>tf",
      run_tests_open_summary,
      desc = "Run tests in current file and open summary.",
    },
    {
      "<leader>tt",
      function()
        neotest.run.run()
      end,
      desc = "Run closest test.",
    },
    {
      "<leader>tv",
      function()
        neotest.output_panel.toggle()
      end,
      desc = "Toggle output panel.",
    },
  },
  -- config = function()
  --   require("neotest").setup({
  --     on_output = function(output)
  --       if output.status == "failed" then
  --         require("neotest").output_panel.open()
  --       end
  --     end,
  --   })
  -- end,
}
