return {
  -- fork to generate plantuml diagrams locally
  "japalvia/nvim-asciidoc-preview",
  ft = { "asciidoc" },
  build = "cd server && npm install --omit=dev --no-save",
  ---@module 'asciidoc-preview'
  ---@type asciidoc-preview.Config
  opts = {
    server = {
      converter = "cmd",
    },
    preview = {
      position = "current",
    },
  },
}
