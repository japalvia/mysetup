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

-- Override LazyVim's Ctrl-S to save all buffers instead of just current buffer
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>wa<cr><esc>", { desc = "Save all buffers" })

-- Remove LazyVim's Alt-j/k mappings to fix Esc+motion behavior in tmux
local del = vim.keymap.del

del("n", "<A-j>")
del("n", "<A-k>")
del("i", "<A-j>")
del("i", "<A-k>")
del("v", "<A-j>")
del("v", "<A-k>")
