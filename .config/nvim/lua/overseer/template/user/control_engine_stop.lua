return {
  name = "Control Engine: Stop",
  builder = function()
    return {
      cmd = { "docker" },
      args = {
        "exec",
        "ce-lsp",
        "pkill",
        "-9",
        "control_engine",
      },
    }
  end,
  condition = {
    callback = function()
      return vim.fn.getcwd():match("control%-engine") ~= nil
    end,
  },
}
