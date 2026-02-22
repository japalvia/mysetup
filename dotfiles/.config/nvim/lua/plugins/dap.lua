return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    config = function()
      local dap = require("dap")

      -- C/C++ configuration for cross-compiled aarch64
      dap.adapters.cppdbg_remote = {
        id = "cppdbg",
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" },
      }

      -- Remote debugging configuration for aarch64
      dap.configurations.cpp = dap.configurations.cpp or {}
      dap.configurations.c = dap.configurations.c or {}

      table.insert(dap.configurations.cpp, {
        name = "Remote Debug (aarch64)",
        type = "cppdbg_remote",
        request = "launch",
        MIMode = "gdb",
        miDebuggerPath = "aarch64-linux-gnu-gdb", -- Cross-compile toolchain GDB
        miDebuggerServerAddress = function()
          return vim.fn.input("Remote address (host:port): ", "192.168.1.100:1234")
        end,
        program = function()
          return vim.fn.input("Path to executable on target: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        setupCommands = {
          {
            text = "-enable-pretty-printing",
            description = "Enable pretty printing",
            ignoreFailures = false,
          },
          {
            text = "set sysroot", -- Add sysroot if needed for shared libraries
            description = "Set sysroot for cross debugging",
            ignoreFailures = true,
          },
        },
      })

      -- Alternative: Using GDB directly with remote target
      dap.adapters.gdb_remote = {
        type = "executable",
        command = "aarch64-linux-gnu-gdb",
        args = { "-i", "dap" },
      }

      table.insert(dap.configurations.cpp, {
        name = "GDB Remote (aarch64) - Manual",
        type = "gdb_remote",
        request = "attach",
        program = function()
          return vim.fn.input("Local path to binary (with debug symbols): ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        target = function()
          return vim.fn.input("Remote target (host:port): ", "192.168.1.100:1234")
        end,
        setupCommands = {
          {
            text = "-enable-pretty-printing",
            ignoreFailures = false,
          },
        },
      })

      -- QEMU user-mode debugging (for testing without hardware)
      table.insert(dap.configurations.cpp, {
        name = "QEMU aarch64 Debug",
        type = "cppdbg_remote",
        request = "launch",
        MIMode = "gdb",
        miDebuggerPath = "aarch64-linux-gnu-gdb",
        miDebuggerServerAddress = "localhost:1234",
        program = function()
          local exe = vim.fn.input("Path to aarch64 executable: ", vim.fn.getcwd() .. "/", "file")
          -- Start QEMU with gdbserver in background
          vim.fn.jobstart(string.format("qemu-aarch64 -g 1234 %s", exe))
          vim.wait(500) -- Give QEMU time to start
          return exe
        end,
        cwd = "${workspaceFolder}",
        setupCommands = {
          {
            text = "-enable-pretty-printing",
            ignoreFailures = false,
          },
        },
      })

      -- Copy configurations to C as well
      for _, config in ipairs(dap.configurations.cpp) do
        table.insert(dap.configurations.c, vim.deepcopy(config))
      end
    end,
  },
}
