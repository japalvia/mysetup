return {
  "folke/sidekick.nvim",
  keys = {
    -- C-. has problems passing through mosh/tmux, use Alt-. instead
    { "<c-.>", false, mode = { "n", "t", "i", "x" } },
    {
      "<M-.>",
      function()
        require("sidekick.cli").focus()
      end,
      desc = "Sidekick Focus",
      mode = { "n", "t", "i", "x" },
    },
  },
  opts = {
    cli = {
      win = {
        keys = {
          hide_ctrl_dot = false,
          hide_alt_dot = { "<M-.>", "hide", mode = "nt", desc = "hide the terminal window" },
        },
        split = {
          width = 0.25, -- up to 50% of available columns
        },
      },
    },
  },
  config = function(_, opts)
    require("sidekick").setup(opts)

    -- Re-apply 50% width on terminal resize (e.g. sway fullscreen toggle)
    vim.api.nvim_create_autocmd("VimResized", {
      callback = function()
        local target = math.floor(vim.o.columns * 0.5)
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.w[win].sidekick_cli then
            pcall(vim.api.nvim_win_set_width, win, target)
          end
        end
      end,
    })
  end,
}
