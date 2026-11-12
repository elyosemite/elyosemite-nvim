-- Debugger. Marque um breakpoint com <leader>db e aperte <F5>.
-- A interface abre sozinha ao iniciar e fecha ao terminar.
-- Docs: https://github.com/mfussenegger/nvim-dap · https://github.com/rcarriga/nvim-dap-ui
local function dap(fn, ...)
  local args = { ... }
  return function() require("dap")[fn](unpack(args)) end
end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
    { "theHamsta/nvim-dap-virtual-text", opts = {} }, -- valores das variáveis ao lado do código
    -- Adapters por linguagem; os debuggers são instalados pelo Mason (plugins/lsp/mason-config.lua)
    "leoluz/nvim-dap-go",            -- Go (delve)
    "mfussenegger/nvim-dap-python",  -- Python (debugpy)
  },
  keys = {
    { "<F5>", dap("continue"), desc = "Debug: start / continue" },
    { "<F10>", dap("step_over"), desc = "Debug: step over" },
    { "<F11>", dap("step_into"), desc = "Debug: step into" },
    { "<S-F11>", dap("step_out"), desc = "Debug: step out" },
    { "<leader>db", dap("toggle_breakpoint"), desc = "Toggle breakpoint" },
    {
      "<leader>dB",
      function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end,
      desc = "Conditional breakpoint",
    },
    { "<leader>dc", dap("continue"), desc = "Start / continue" },
    { "<leader>dr", dap("repl.toggle"), desc = "Toggle REPL" },
    { "<leader>dt", dap("terminate"), desc = "Stop" },
    { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle debug UI" },
    { "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "Evaluate expression" },
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()

    require("dap-go").setup()
    local mason = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/"
    local python = mason .. (vim.fn.has("win32") == 1 and "Scripts/python.exe" or "bin/python")
    require("dap-python").setup(vim.fn.executable(python) == 1 and python or "python")

    dap.listeners.after.event_initialized.dapui = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui = function() dapui.close() end
    dap.listeners.before.event_exited.dapui = function() dapui.close() end

    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
    vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual" })
  end,
}
