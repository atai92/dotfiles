local snacks = require("snacks")
return -- lazy.nvim
{
  "folke/snacks.nvim",
  opts = {
    animate = {
      enabled = false,
      duration = 10,
      easing = "linear",
      fps = 60,
    },
    terminal = {},
    dashboard = {
      -- your dashboard configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      sections = {
        {
          pane = 2,
          {
            section = "terminal",
            cmd = "chafa ~/dotfiles/.config/nvim/lua/plugins/remy-ball.png -f symbol --symbols vhalf --scale 2.5; sleep .1",
            height = 40,
            padding = 1,
          },
        },
        {
          pane = 1,
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
    git = {
      enabled = true,
    },
    gitbrowse = {
      enabled = true,
      notify = true,
      what = "file",
      line_start = nil,
      line_end = nil,
      url_patterns = {
        ["github%.com"] = {
          branch = "/tree/{branch}",
          file = "/blob/{branch}/{file}#L{line_start}-L{line_end}",
          commit = "/commit/{commit}",
        },
        ["github%.snooguts%.net"] = {
          branch = "/tree/{branch}",
          file = "/blob/{branch}/{file}#L{line_start}-L{line_end}",
          commit = "/commit/{commit}",
        },
        ["gitlab%.com"] = {
          branch = "/-/tree/{branch}",
          file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
          commit = "/-/commit/{commit}",
        },
        ["bitbucket%.org"] = {
          branch = "/src/{branch}",
          file = "/src/{branch}/{file}#lines-{line_start}-L{line_end}",
          commit = "/commits/{commit}",
        },
      },
    },
    statuscolumn = {
      enabled = false,
    },
    notify = {
      enabled = true,
    },
    notifier = {
      enabled = true,
      timeout = 2000,
      style = "fancy",
    },
  },
  keys = {
    {
      "<leader>gB",
      function()
        snacks.gitbrowse()
      end,
      desc = "Git Browse",
    },
    {
      "<leader>gb",
      function()
        snacks.git.blame_line()
      end,
      desc = "Git Blame Line",
    },
    {
      "<leader>n",
      function()
        snacks.notifier.show_history()
      end,
      desc = "Notifier History",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
