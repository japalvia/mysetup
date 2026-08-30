-- lua/plugins/copilot.lua
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    model = "Auto",
    dependencies = { "zbirenbaum/copilot.lua" },
  },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      model = "Auto",
      suggestion = {
        enabled = false,
        auto_trigger = false,
      },
      panel = {
        enabled = false,
      },
    },
    -- ensure Copilot is explicitly disabled after setup so suggestions are off by default
    config = function(_, opts)
      require("copilot").setup(opts)
      -- disable inline suggestions and completions on startup
      pcall(function()
        require("copilot.command").disable()
      end)
    end,
    keys = {
      {
        "<leader>at",
        function()
          if require("copilot.client").is_disabled() then
            require("copilot.command").enable()
          else
            require("copilot.command").disable()
          end
        end,
        desc = "Toggle (Copilot)",
      },
    },
  },
}
