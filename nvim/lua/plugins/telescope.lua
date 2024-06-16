return {
  "nvim-telescope/telescope.nvim",
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--column",
          "--hidden",
          "--line-number",
          "--no-heading",
          "--smart-case",
          "--with-filename",
        },
      },
    })
  end,
}
