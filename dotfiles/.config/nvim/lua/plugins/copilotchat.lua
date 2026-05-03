return {
  "CopilotC-Nvim/CopilotChat.nvim",
  opts = {
    mappings = {
      -- Rebind reset to avoid accidentally wiping the prompt
      reset = {
        normal = "<C-S-l>",
        insert = "<C-S-l>",
      },
    },

    -- more agentic behavior
    allow_tools = true,
    auto_context = true,

    -- Allow reading buffers/files without re-selecting
    context = {
      buffer = true,
      files = true,
      git = true,
    },

    -- Reduce "please select" behavior
    prompt_prepend = [[
You are an autonomous coding agent.
Infer structure and context from the current buffer before asking questions.
If the user asks about "the table", identify it from nearby content.
]],
  },
}
