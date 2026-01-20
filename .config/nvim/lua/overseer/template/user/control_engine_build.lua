return {
  name = "Control Engine: Build",
  builder = function()
    return {
      cmd = { "docker" },
      args = {
        "exec",
        "ce-lsp",
        "bash",
        "-c",
        "/usr/bin/cmake --build /tmp/control-engine/cmake-build-debug-docker --target all -- -j 8",
      },
      components = {
        { "on_output_quickfix", open = true },
        "default",
      },
    }
  end,
  condition = {
    callback = function()
      return vim.fn.getcwd():match("control%-engine") ~= nil
    end,
  },
}
