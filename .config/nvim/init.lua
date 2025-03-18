_G.dd = function(...)
  Snacks.debug.inspect(...)
end
_G.bt = function()
  Snacks.debug.backtrace()
end
vim.print = _G.dd
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.shell = "bash"
vim.opt.fileencoding = "utf-8"

-- No autoselect on menu open.
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }

-- Increase mouse scroll
-- vim.opt.mousescroll = "ver:8,hor:6"

vim.opt.mouse = ""

-- triggers CursorHold event faster
vim.opt.updatetime = 200
