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

require("vim-commands")
-- require("lazy").setup("plugins")
require("lazy").setup({ import = "plugins" }, {
  change_detection = {
    notify = false,
  },
})

require("my_plugins.swagger_gen")
vim.api.nvim_create_user_command("GenerateSwagger", function()
  require("my_plugins.swagger_gen").generate_swagger_docs()
end, {})
