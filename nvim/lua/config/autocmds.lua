-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable diagnostics and enable word wrap for AI prompt buffers (Claude Code, Copilot, Codex)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*/claude-prompt-*", "*/copilot-edit-*/COPILOT_PROMPT.md", "*/T/.tmp*.md" },
  callback = function(args)
    if vim.fn.has("nvim-0.10") == 1 then
      vim.diagnostic.enable(false, { bufnr = args.buf })
    else
      vim.diagnostic.disable(args.buf)
    end
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.signcolumn = "no"
  end,
})
