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
