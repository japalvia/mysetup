return {
  {
    "mfussenegger/nvim-dap",
    opts = function()
      require("dap").adapters.codelldb = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
      }
    end,
  },
}
