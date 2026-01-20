return {
  name = "Control Engine: Run",
  builder = function()
    return {
      cmd = { "docker" },
      args = {
        "exec",
        "-it",
        "-e", "CENG_NATS_URL=nats://host.docker.internal:9222",
        "-w", "/tmp/control-engine/cmake-build-debug-docker",
        "ce-lsp",
        "./control_engine",
        "./testExtensions",
        "-x", "demo",
        "-p", "../CE-Ext-Modbus/output",
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
