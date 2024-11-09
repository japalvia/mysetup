return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  -- { "phha/zenburn.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
      -- colorscheme = "zenburn",
    },
  },
}
