-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Overseer: keybinding to restart the last task
vim.keymap.set("n", "<leader>or", function()
  local overseer = require("overseer")
  local tasks = overseer.list_tasks({ recent_first = true })
  if #tasks == 0 then
    vim.notify("No previous Overseer task found", vim.log.levels.WARN)
    return
  end
  local last_task = tasks[1]
  if last_task.status == "RUNNING" then
    vim.notify("Last task is still running", vim.log.levels.INFO)
  else
    last_task:restart()
  end
end, { desc = "Rerun last task" })

-- Save all open buffers with Ctrl-Shift-S
vim.api.nvim_set_keymap("n", "<C-S-s>", ":wa<CR>", { noremap = true, silent = true, desc = "Save all buffers" })
vim.api.nvim_set_keymap("i", "<C-S-s>", "<Esc>:wa<CR>a", { noremap = true, silent = true, desc = "Save all buffers" })

-- Remove LazyVim's Alt-j/k mappings to fix Esc+motion behavior in tmux
local del = vim.keymap.del

del("n", "<A-j>")
del("n", "<A-k>")
del("i", "<A-j>")
del("i", "<A-k>")
del("v", "<A-j>")
del("v", "<A-k>")
