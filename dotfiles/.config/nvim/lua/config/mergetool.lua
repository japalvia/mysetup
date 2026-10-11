local M = {}

local group = vim.api.nvim_create_augroup("MergeTool", { clear = true })

local diff_highlights = {
  DiffAdd = { bg = "#264f26", fg = "#ffffff" },
  DiffDelete = { bg = "#5a1d1d", fg = "#ffffff" },
  DiffChange = { bg = "#3a3a1f", fg = "#ffffff" },
  DiffText = { bg = "#fabd2f", fg = "#282828" },
  DiffTextAdd = { bg = "#fabd2f", fg = "#282828" },
}

local diffview_highlights = {
  DiffviewDiffAdd = diff_highlights.DiffAdd,
  DiffviewDiffDelete = diff_highlights.DiffDelete,
  DiffviewDiffChange = diff_highlights.DiffChange,
  DiffviewDiffText = diff_highlights.DiffText,
  DiffviewDiffTextInline = diff_highlights.DiffText,
  DiffviewDiffAddInline = diff_highlights.DiffAdd,
  DiffviewDiffDeleteInline = diff_highlights.DiffDelete,
  DiffviewDiffDeleteDim = diff_highlights.DiffDelete,
  DiffviewDiffAddAsDelete = diff_highlights.DiffDelete,
}

local function set_highlights()
  for name, highlight in pairs(diff_highlights) do
    vim.api.nvim_set_hl(0, name, highlight)
  end

  for name, highlight in pairs(diffview_highlights) do
    vim.api.nvim_set_hl(0, name, highlight)
  end
end

local function disable_buffer_highlighting(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  vim.api.nvim_buf_call(bufnr, function()
    vim.cmd("syntax off")
  end)

  if vim.treesitter and vim.treesitter.stop then
    vim.treesitter.stop(bufnr)
  end

  if vim.diagnostic and vim.diagnostic.enable then
    vim.diagnostic.enable(false, { bufnr = bufnr })
  end

  if vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
  end

  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if vim.lsp.semantic_tokens then
      vim.lsp.semantic_tokens.stop(bufnr, client.id)
    end
    vim.lsp.buf_detach_client(bufnr, client.id)
  end
end

local function disable_current_buffer(args)
  vim.schedule(function()
    disable_buffer_highlighting(args.buf)
  end)
end

function M.setup()
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = set_highlights,
  })

  vim.api.nvim_create_autocmd({ "BufReadPost", "BufEnter", "BufWinEnter", "FileType" }, {
    group = group,
    callback = disable_current_buffer,
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(args)
      vim.schedule(function()
        disable_buffer_highlighting(args.buf)
      end)
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = { "DiffviewViewOpened", "DiffviewDiffBufRead", "DiffviewDiffBufWinEnter" },
    callback = set_highlights,
  })

  set_highlights()
end

return M
