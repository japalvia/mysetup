return {
  -- QML
  { require("lspconfig").qmlls.setup({}) },

  -- Rust
  {
    require("lspconfig").rust_analyzer.setup({
      settings = {
        ["rust-analyzer"] = {
          cargo = { allFeatures = true, targetDir = true },
          check = { command = "clippy" },
        },
      },
    }),
  },

  -- clangd
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "-j=" .. math.max(math.floor((vim.uv.available_parallelism or vim.loop.available_parallelism)() / 2), 1),
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
