-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Save all buffers automatically when running Overseer tasks
vim.api.nvim_create_autocmd("User", {
  pattern = "OverseerTaskPreStart",
  callback = function()
    vim.cmd("silent! wall")
  end,
  desc = "Save all buffers before Overseer task starts",
})

local set_autoformat = function(pattern, bool_val)
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = pattern,
    callback = function()
      vim.b.autoformat = bool_val
    end,
  })
end

set_autoformat("*/linux/*", false)

-- Lazily start the local PlantUML proxy when PlantUML content is opened.
-- plantuml.js/blockPlantuml.js render diagrams as <img> tags pointing to a server URL;
-- there is no "local command" mode in the plugin. plantuml --http-server is broken
-- (always returns a demo image). plantuml-proxy decodes the request and pipes through
-- 'plantuml -pipe', keeping everything local.
-- Port 18080 avoids conflict with the preview server (8080-9079).
local plantuml_proxy_port = 18080
local plantuml_proxy_checked = false
local plantuml_proxy_checking = false

local function buffer_contains_plantuml(bufnr)
  if vim.bo[bufnr].filetype == "plantuml" then
    return true
  end

  for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
    if line:match("^%s*@startuml") or line:match("^%s*```%s*plantuml%s*$") then
      return true
    end
  end

  return false
end

local function ensure_plantuml_proxy()
  if plantuml_proxy_checked or plantuml_proxy_checking then
    return
  end

  plantuml_proxy_checking = true
  vim.system({ "curl", "-sf", "--max-time", "1", "http://localhost:" .. plantuml_proxy_port }, {}, function(result)
    vim.schedule(function()
      if result.code == 0 then
        plantuml_proxy_checked = true
      else
        local job_id = vim.fn.jobstart({
          "python3",
          vim.fn.expand("~/.local/bin/plantuml-proxy"),
          tostring(plantuml_proxy_port),
        }, { detach = true })

        if job_id > 0 then
          plantuml_proxy_checked = true
        else
          vim.notify("Failed to start local PlantUML proxy server", vim.log.levels.ERROR)
        end
      end

      plantuml_proxy_checking = false
    end)
  end)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "plantuml" },
  callback = function(args)
    if buffer_contains_plantuml(args.buf) then
      ensure_plantuml_proxy()
    end
  end,
  desc = "Start local PlantUML proxy for PlantUML content",
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
