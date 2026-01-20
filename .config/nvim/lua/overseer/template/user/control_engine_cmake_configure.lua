return {
  name = "Control Engine: CMake Configure",
  builder = function()
    return {
      cmd = { "docker" },
      args = {
        "exec",
        "ce-lsp",
        "bash",
        "-c",
        "/usr/bin/cmake -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTS:BOOL=ON -DBUILD_CE_UTILS:BOOL=ON -DENABLE_TRACE_LOGGING:BOOL=OFF -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -G \"Unix Makefiles\" -S /tmp/control-engine -B /tmp/control-engine/cmake-build-debug-docker",
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
