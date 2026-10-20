return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- automatic bullets lists
  {
    "dkarter/bullets.vim",
    init = function()
      vim.g.bullets_outline_levels = { "num" }
    end,
  },

  -- syntax file for PlantUML
  { "aklt/plantuml-syntax" },

  -- seamless pane navigation between tmux and nvim
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- ANSI escape sequence that allows you to copy text into your system
  -- clipboard from anywhere, including from remote SSH sessions
  {
    "ojroques/nvim-osc52",
  },

  -- Format plain text and other non-code (LSP) files
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        text = { "trim_whitespace", "trim_newlines" },
      },
    },
  },

  -- snacks: include hidden files
  {
    "folke/snacks.nvim",
    opts = {
      lazygit = {
        config = {
          os = {
            edit = [[ [ -z "$NVIM" ] && (nvim -- {{filename}}) || (nvim --server "$NVIM" --remote-send "<F12>" && nvim --server "$NVIM" --remote-tab {{filename}}) ]],
            editAtLine = [[ [ -z "$NVIM" ] && (nvim +{{line}} -- {{filename}}) || (nvim --server "$NVIM" --remote-send "<F12>" && nvim --server "$NVIM" --remote-tab {{filename}} && nvim --server "$NVIM" --remote-expr 'cursor({{line}}, 1)' >/dev/null) ]],
          },
        },
        win = {
          wo = {
            winhighlight = "Normal:Normal,NormalNC:Normal,WinBar:SnacksWinBar,WinBarNC:SnacksWinBarNC,FloatTitle:SnacksTitle,FloatFooter:SnacksFooter,WinSeparator:SnacksWinSeparator",
          },
          keys = {
            -- Keep `q` available to LazyGit; remote editing uses `<F12>` below.
            q = false,
            ["<F12>"] = { "hide", mode = { "n", "t" } },
          },
        },
      },
      picker = {
        -- grep
        hidden = true,
        ignored = false,
        -- find
        sources = {
          files = {
            hidden = true,
          },
        },
      },
    },
  },
}
