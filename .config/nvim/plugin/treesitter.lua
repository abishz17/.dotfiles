-- Treesitter (hook for TSUpdate is in init.lua)
vim.pack.add({
  'https://github.com/nvim-treesitter/nvim-treesitter',
})

-- Latest nvim-treesitter dropped the old configs module.
-- Highlighting and indentation are now built into Neovim core,
-- but only enabled by default for a few bundled languages (lua, markdown, help, query).
-- We enable treesitter highlighting + indentation for ALL filetypes that have a parser.
require("nvim-treesitter").setup()

vim.api.nvim_create_autocmd("FileType", { callback = function()
  if pcall(vim.treesitter.start) then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end })

-- Ensure these parsers are installed
local ensure_installed = {
  "html", "c", "lua", "vim", "vimdoc", "query",
  "go", "python", "rust", "toml", "sql", "yaml",
}

vim.api.nvim_create_autocmd("VimEnter", { once = true, callback = function()
  local installed = require("nvim-treesitter").get_installed()
  local to_install = {}
  for _, lang in ipairs(ensure_installed) do
    if not vim.tbl_contains(installed, lang) then
      table.insert(to_install, lang)
    end
  end
  if #to_install > 0 then
    vim.cmd("TSInstall " .. table.concat(to_install, " "))
  end
end })
