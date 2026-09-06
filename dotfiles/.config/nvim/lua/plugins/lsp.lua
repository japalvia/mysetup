return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        qmlls = {},
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true, targetDir = true },
              check = { command = "clippy" },
            },
          },
        },
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
