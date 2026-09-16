-- Tell kitty when nvim is focused so `map --when-focus-on var:in_editor` bindings apply.
local function set_var(value)
  local seq = "\x1b]1337;SetUserVar=in_editor" .. (value and "=MQ==" or "") .. "\007"
  if vim.api.nvim_ui_send then
    vim.api.nvim_ui_send(seq)
  else
    io.stdout:write(seq)
  end
end

local group = vim.api.nvim_create_augroup("KittyInEditor", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "VimResume", "UIEnter" }, {
  group = group,
  callback = function() set_var(true) end,
})
vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
  group = group,
  callback = function() set_var(false) end,
})
