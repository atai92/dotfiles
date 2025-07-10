return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  keys = {
    { "<leader>oo", ":ObsidianQuickSwitch<CR>", "Show all notes in your workspace" },
    { "<leader>oe", ":ObsidianQuickSwitch<CR>", "Show all notes in your workspace" },
    { "<leader>on", ":ObsidianNew<CR>", desc = "Create a new note in your workspace" },
    { "<leader>os", ":ObsidianSearch<CR>", desc = "Search for notes in your vault workspace" },
    { "<leader>ol", ":ObsidianLinks<CR>", desc = "Collect all links into a picker window" },
    { "<leader>ow", ":ObsidianWorkspace<CR>", desc = "Change the vault workspace" },
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    -- "OXY2DEV/markview.nvim",
  },
  completion = {
    -- Set to false to disable completion.
    nvim_cmp = true,
    -- Trigger completion at 2 chars.
    min_chars = 3,
  },
  opts = {
    workspaces = {
      {
        name = "work",
        path = "~/vaults/work",
      },
      {
        name = "interviews",
        path = "~/interviews",
      },
    },
  },
}
