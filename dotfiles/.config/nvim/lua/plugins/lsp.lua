return {
  -- QML
  { require("lspconfig").qmlls.setup({}) },

  -- Rust
  { require("lspconfig").rust_analyzer.setup({}) },

  -- clangd
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            "--query-driver=/home/*/dev/**/aarch64-helix-linux-g++,/home/*/dev/**/arm-helix-linux-gnueabi*,/usr/bin/*",
          },
        },
      },
    },
  },
}
