return {
  "folke/sidekick.nvim",
  opts = {
    cli = {
      win = {
        split = {
          width = 0.5, -- up to 50% of available columns
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
