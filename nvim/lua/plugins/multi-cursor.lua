return {
  "mg979/vim-visual-multi",
  branch = "master",
  event = "VeryLazy",
  init = function()
    vim.g.VM_maps = {
      ["Find Under"] = "<C-n>",
      ["Find Subword Under"] = "<C-n>",
      ["Select All"] = "<C-S-l>",
      ["Add Cursor Down"] = "<C-Down>",
      ["Add Cursor Up"] = "<C-Up>",
      ["Find Next"] = "]",
      ["Find Prev"] = "[",
      ["Goto Next"] = "}",
      ["Goto Prev"] = "{",
      ["Seek Next"] = "<C-f>",
      ["Seek Prev"] = "<C-b>",
      ["Skip Region"] = "<C-x>",
    }

    vim.g.VM_maps["Exit"] = "<Esc>"
  end,
}
