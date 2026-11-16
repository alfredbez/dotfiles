-- Rex server configuration; reload with `rex config reload`.
-- A vertical divider puts the new pane to the right; a horizontal one below.
rex.bind("ctrl+b>v", "pane.split", { direction = "right" })
rex.bind("ctrl+b>alt+7", "pane.split", { direction = "right" }) -- | on German macOS keyboards
rex.bind("ctrl+b>-", "pane.split", { direction = "down" })

-- Familiar tmux-style pane controls.
rex.bind("ctrl+b>left", "pane.focus", { direction = "left" })
rex.bind("ctrl+b>right", "pane.focus", { direction = "right" })
rex.bind("ctrl+b>up", "pane.focus", { direction = "up" })
rex.bind("ctrl+b>down", "pane.focus", { direction = "down" })
rex.bind("ctrl+b>z", "pane.zoom")

-- Ctrl+B is now a Rex prefix. Send it through for nested tmux or shell apps.
rex.bind("ctrl+b>ctrl+b", "pane.send_key", { key = "ctrl+b" })

-- Rex's app-side reload can run with a narrower PATH than an interactive shell.
local function resolve_bin(name, fallbacks)
  local result = rex.exec({ "which", name }, { timeout = 5 })
  if result and result.ok then
    return name
  end
  for _, path in ipairs(fallbacks) do
    local file = io.open(path, "rb")
    if file then
      file:close()
      return path
    end
  end
  return name
end

-- Vim-style scrollback selection and copy (https://github.com/CJNE/rex-copy-mode).
require("copy-mode").setup({
  key = "ctrl+b>y",
  nvim = resolve_bin("nvim", { "/opt/homebrew/bin/nvim", "/usr/local/bin/nvim" }),
  rex = resolve_bin("rex", {
    "/Applications/Rex.app/Contents/Helpers/Rex Server.rex/Contents/MacOS/rex",
    "/Applications/Rex Beta.app/Contents/Helpers/Rex Server.rex/Contents/MacOS/rex",
  }),
})

rex.bind("ctrl+b>shift+p", "pane.paste")
