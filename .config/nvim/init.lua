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
