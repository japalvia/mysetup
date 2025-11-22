return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- Replace the filename section with full relative path
    opts.sections.lualine_c = {
      {
        "filename",
        path = 3, -- 0 = just filename, 1 = relative path, 2 = absolute path, 3 = absolute with tilde
        shorting_target = 40, -- Shorten path if longer than 40% of statusline
      },
    }
  end,
}
