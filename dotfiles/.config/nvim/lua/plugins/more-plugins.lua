-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- add bullets
  { "dkarter/bullets.vim" },

  -- Configure QML LSP
  { require("lspconfig").qmlls.setup({}) },

  { require("lspconfig").rust_analyzer.setup({}) },

  { "aklt/plantuml-syntax" },

  -- https://github.com/Saghen/blink.cmp/issues/2155
  {
    "saghen/blink.cmp",
    opts = {
      fuzzy = {
        implementation = "lua",
      },
    },
  },
}
