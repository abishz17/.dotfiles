local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- HACK: Workaround for neovim/neovim#38466
-- treesitter.get_range crashes with nil node; remove after updating to a fixed Neovim release
local ts_ok, ts = pcall(require, "vim.treesitter")
if ts_ok and ts.get_range then
  local original_get_range = ts.get_range
  ts.get_range = function(node, source, metadata)
    if not node then
      return { 0, 0, 0, 0, 0, 0 }
    end
    local ok, result = pcall(original_get_range, node, source, metadata)
    if ok then
      return result
    end
    return { 0, 0, 0, 0, 0, 0 }
  end
end

require("vim-commands")
-- require("lazy").setup("plugins")
require("lazy").setup({ import = "plugins" }, {
  change_detection = {
    notify = false,
  },
})

