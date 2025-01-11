return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach", -- Or `LspAttach`
  priority = 1000, -- needs to be loaded in first
  config = function()
    vim.diagnostic.config({ virtual_text = false })
    require("tiny-inline-diagnostic").setup({
      preset = "powerline",
      options = {
        throttle = 0,
        show_all_diags_on_cursorline = true,
        multiple_diag_under_cursor = true,
        multilines = true,
      },
    })
  end,
}
