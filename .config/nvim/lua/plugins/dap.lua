return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
    "williamboman/mason.nvim",
  },
  lazy = true,
  config = function()
    local dap = require("dap")
    dap.adapters.go = {
      type = "executable",
      command = "node",
      args = { os.getenv("HOME") .. "/dev/golang/vscode-go/extension/dist/debugAdapter.js" },
      options = {
        env = {
          KUBEBUILDER_ASSETS = "/Users/alan.tai/Library/Application",
        },
      },
    }
    dap.configurations.go = {
      {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}",
        dlvToolPath = vim.fn.exepath("dlv"),
      },
    }
  end,
}
