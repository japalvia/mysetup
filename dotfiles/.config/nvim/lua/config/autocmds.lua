-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local set_autoformat = function(pattern, bool_val)
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = pattern,
    callback = function()
      vim.b.autoformat = bool_val
    end,
  })
end

set_autoformat("*/linux/*", false)

-- Save all buffers automatically when running Overseer tasks
vim.api.nvim_create_autocmd("User", {
  pattern = "OverseerTaskPreStart",
  callback = function()
    vim.cmd("silent! wall")
  end,
  desc = "Save all buffers before Overseer task starts",
})

-- reload unmodified files when they change on disk
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("fs_watch_reload", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local fname = vim.api.nvim_buf_get_name(bufnr)
    if fname == "" or not vim.uv.fs_stat(fname) then
      return
    end

    local handle = vim.uv.new_fs_event()
    handle:start(fname, {}, function(err)
      if err then
        return
      end
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(bufnr) and not vim.bo[bufnr].modified then
          vim.cmd("checktime " .. bufnr)
        end
      end)
    end)

    vim.api.nvim_buf_attach(bufnr, false, {
      on_detach = function()
        handle:stop()
        handle:close()
      end,
    })
  end,
})
