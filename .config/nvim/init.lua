-- Enable faster Lua module loading (recommended by vim.pack guide)
vim.loader.enable()

-- Load base vim settings and keymaps
require("vim-commands")

-- Define hooks for plugins that need build steps.
-- IMPORTANT: This must come BEFORE any vim.pack.add() call (per the article).
vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind

  -- Treesitter: update parsers on install/update
  if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
    if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
    vim.cmd('TSUpdate')
  end

  -- telescope-fzf-native: run `make` on install/update
  if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
    local path = vim.fn.stdpath('data') .. '/site/pack/core/opt/telescope-fzf-native.nvim'
    vim.fn.system({ 'make', '-C', path })
  end

  -- blink.cmp: run `cargo build --release` on install/update
  if name == 'blink.cmp' and (kind == 'install' or kind == 'update') then
    local path = vim.fn.stdpath('data') .. '/site/pack/core/opt/blink.cmp'
    vim.fn.system('cd ' .. vim.fn.shellescape(path) .. ' && cargo build --release')
  end
end })

-- All plugin files live in plugin/ and are auto-sourced alphabetically by Neovim.
-- No further setup needed here.
